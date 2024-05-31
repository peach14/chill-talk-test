import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/config/routing/route_path.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/constants.dart';
import '../model/erroe_model_login.dart';
import '../model/request_login_model.dart';
import '../model/response_login_model.dart';
import '../service/login_service.dart';

class SplashViewModel extends GetxController {
  Future<void> checkTokenAndNavigate({required BuildContext context}) async {
    // get Data in Local
    ErrorModelLogin? resError;
    final getRespLogin = await SecureStorage.instance.read(kResponseLogin);
    final respLogin = responseModelLoginFromJson(getRespLogin ?? '');
    final pass = await SecureStorage.instance.getPass();
    String decoded = utf8.decode(base64.decode(pass ?? ''));
    int paaConvert = int.parse(decoded);

// refresh Login
    // ignore: use_build_context_synchronously
    final res = await LoginService.instance.refreshRepoLogin(
        requestModel:
            RequestModel(username: respLogin.email, password: paaConvert),
        context: context);
    final refLogin = responseModelLoginFromJson(res);
    resError = errorModelLoginFromJson(res);
    final getToken = await SecureStorage.instance.getToken();

// check Status user
    // ignore: unnecessary_null_comparison
    if (resError != null) {
      int statusLocal = int.parse(getToken ?? '7');

      if (statusLocal != resError.status) {
        // ignore: use_build_context_synchronously
        context.go(kNevLogin);
      } else {
        // ignore: use_build_context_synchronously
        context.go(kNevMain);
      }
    } else {
      int statusLocal = int.parse(getToken ?? '7');

      if (statusLocal == refLogin.status) {
        // ignore: use_build_context_synchronously
        context.go(kNevMain);
      } else {
        // ignore: use_build_context_synchronously
        context.go(kNevLogin);
      }
    }
  }
}
