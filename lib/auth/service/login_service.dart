import 'dart:async';

import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/service/base/api_endpoints.dart';
import '../../base/service/base/base_api_service.dart';
import '../model/request_login_model.dart';

class LoginService {
  LoginService._();
  static final instance = LoginService._();

  Future<String> repoLogin({
    required RequestModel requestModel,
    required BuildContext context,
  }) async {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: CustomColors.primaryColor,
          backgroundColor:
              CustomColors.borderColor2, // Corrected "gray" to "grey"
        ),
      ),
    );

    // bool isTimeout = false;
    //
    // // Start a timer to detect if the request takes longer than 5 seconds
    // Timer(const Duration(seconds: 5), () {
    //   isTimeout = true;
    //   if (Navigator.canPop(context)) {
    //     context.pop();
    //
    //     dialogAlert(
    //       context: context,
    //       titleIcon: const Text("เกิดข้อผิดพลาด"),
    //       content: const Text("กรุณาลองใหม่อีกครั้ง"),
    //       onTap: () {
    //         context.pop();
    //       },
    //     );
    //   }
    // });

    // Perform the request
    final res = await Get.find<BaseApiService>().postRequest(
      url: ApiEndPoints.instan.checkAuThen,
      body: requestModelToJson(data: requestModel),
      context: context,
    );

    // ignore: use_build_context_synchronously
    context.pop();

    // If the request completes before the timeout, close the loading dialog
    // if (!isTimeout) {
    //   if (Navigator.canPop(context)) {
    //     context.pop();
    //   }
    //   return res.toString();
    // }
    return res.toString();
    // If the request took longer than the timeout, return null as the error dialog is already shown
  }

  Future<String> refreshRepoLogin({
    required RequestModel requestModel,
    required BuildContext context,
  }) async {
    // Perform the request
    final res = await Get.find<BaseApiService>().postRequest(
      url: ApiEndPoints.instan.checkAuThen,
      body: requestModelToJson(data: requestModel),
      context: context,
    );

    return res.toString();
  }
}
