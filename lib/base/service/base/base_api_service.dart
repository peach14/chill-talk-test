import 'dart:convert';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      }
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        colorButton: const Color(0xff1a6cae),
        content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
        onTap: () {
          Navigator.pop(context);
          // Reset isDialogShown when dialog is dismissed
        },
      );
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
      }
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        colorButton: const Color(0xff1a6cae),
        content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
        onTap: () {
          Navigator.pop(context);
          // Reset isDialogShown when dialog is dismissed
        },
      );
    }
  }
}
