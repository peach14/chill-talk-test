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

  Future<dynamic> getRequest({required String url}) async {
    return await _dio.get(url);
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
        log("BESE_API>>>> ERROE>>>>>>>>>>>>$e");
      }
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
        onTap: () {
          Navigator.pop(context);
          // Reset isDialogShown when dialog is dismissed
        },
      );
    }
  }
}
