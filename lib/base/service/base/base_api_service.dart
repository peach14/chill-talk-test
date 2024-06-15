import 'dart:convert';
import 'dart:developer';

import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../component/dialog_alert.dart';
import 'api_endpoints.dart';

class BaseApiService extends GetConnect {
  final Dio _dio = Dio();
  @override
  void onInit() {
    _dio.options.baseUrl = ApiEndPoints.instan.baseUrl;

    super.onInit();
  }

  Future<dynamic> getRequest(
      {required BuildContext context, required String url}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        return await _dio.get("${ApiEndPoints.instan.getHistory}$url");
      } catch (e) {
        log("BESE_API>>getRequest>> ERROE>>>>>>>>>>>>$e");
        // ignore: use_build_context_synchronously
        return dialogAlert(
          context: context,
          colorButton: CustomColors.primaryColor,
          content: const Text("ระบบผิดพลาดลองใหม่อีกครั้ง"),
          onTap: () {
            context.pop();
            // Reset isDialogShown when dialog is dismissed
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      // dialogAlert(
      //   context: context,
      //   colorButton: CustomColors.primaryColor,
      //   content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
      //   onTap: () {
      //     //  context.pushReplacement(kNevHistory);
      //     context.canPop();
      //     // Reset isDialogShown when dialog is dismissed
      //   },
      // );
    }
  }

  Future<dynamic> postRequest(
      {required String url,
      required dynamic body,
      required BuildContext context}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final deCode = json.decode(body) as Map;
        return await _dio.post(
          url,
          data: deCode,
          options: Options(
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
            },
          ),
        );
      } catch (e) {
        log("BESE_API>>postRequest>> ERROE>>>>>>>>>>>>$e");
        // ignore: use_build_context_synchronously
        return dialogAlert(
          context: context,
          colorButton: CustomColors.primaryColor,
          content: const Text("ระบบผิดพลาดลองใหม่อีกครั้ง"),
          onTap: () {
            context.pop();
            // Reset isDialogShown when dialog is dismissed
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        barrierDismissible: false,
        context: context,
        colorButton: CustomColors.primaryColor,
        content: const Text("ออกจากแอพ"),
        alertTitle: "ไม่พบ สัญญาณอินเตอร์เน็ต",
        onTap: () {
          SystemNavigator.pop();
          // context.pop();
          // Reset isDialogShown when dialog is dismissed
        },
      );
    }
  }
}
