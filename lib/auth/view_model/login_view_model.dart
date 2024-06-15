import 'dart:convert';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/component/dialog_alert.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/constants.dart';
import '../model/erroe_model_login.dart';
import '../model/request_login_model.dart';
import '../model/response_login_model.dart';
import '../service/login_service.dart';

class LoginViewModel extends GetxController {
  final showPassword = false.obs;

  final textEmail = ''.obs;
  final textPassword = ''.obs;
  final validEmail = false.obs;
  final validPass = false.obs;
  ResponseModelLogin? response;
  final resError = ErrorModelLogin(status: 9, message: '').obs;

  void setEnablePassword() {
    showPassword.value = !showPassword.value;
  }

  void setEmail({required String email}) {
    textEmail.value = email;
    if (textEmail.value.isNotEmpty) {
      validEmail.value = false;
    } else {
      resError.value = ErrorModelLogin(status: 9, message: '');
      validEmail.value = true;
    }
  }

  void setPassword({required String passwords}) {
    textPassword.value = passwords;
    if (textPassword.value.isNotEmpty) {
      validPass.value = false;
    } else {
      resError.value = ErrorModelLogin(status: 9, message: '');
      validPass.value = true;
    }
  }

  void setValidate({required BuildContext context}) async {
    if (textEmail.isEmpty) {
      validEmail.value = true;
    }
    if (textPassword.isEmpty) {
      validPass.value = true;
    }
    if (!validEmail.value && !validPass.value) {
      login(context: context);
    }
  }

  void login({required BuildContext context}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      final res = await LoginService.instance.repoLogin(
          requestModel: RequestModel(
              username: textEmail.value, password: textPassword.value),
          context: context);
      print(res);
      if (errorModelLoginFromJson(res).status == kNoSuccessToken) {
        resError.value = errorModelLoginFromJson(res);
      } else if (responseModelLoginFromJson(res).status == keySuccessToken) {
        response = responseModelLoginFromJson(res);
        LocalStorageSecureService.instance.write(kResponseLogin, res);
        String? getResponse =
            await LocalStorageSecureService.instance.read(kResponseLogin);
        final token =
            responseModelLoginFromJson(getResponse ?? 'NoData_Get_response');
        LocalStorageSecureService.instance.saveToken(token.status.toString());
        String encoded = base64.encode(utf8.encode(textPassword.value));
        LocalStorageSecureService.instance.savePass(encoded);
        textEmail.value = '';
        textPassword.value = '';
        resError.value = ErrorModelLogin(status: 9, message: '');
        // ignore: use_build_context_synchronously
        context.go(kNevMain);
      }
      // ignore: use_build_context_synchronously
      log("ใน LoginService >>>>>>>>>>>>>>>>>>>$res");
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        colorButton: CustomColors.primaryColor,
        content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
        onTap: () {
          context.pop();
          // Reset isDialogShown when dialog is dismissed
        },
      );
    }
  }
}
