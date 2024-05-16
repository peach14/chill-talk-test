import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/service/base/api_endpoints.dart';
import '../../base/service/base/base_api_service.dart';
import '../model/request_record_model.dart';

class RecordService {
  RecordService._();
  static final instance = RecordService._();

  Future<String> recordWork({
    required RespModelRecordWork requestModel,
    required BuildContext context,
  }) async {
    // Show the loading dialog immediately
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: const Color(0xff1a6cae),
          backgroundColor: Colors.grey.shade400, // Corrected "gray" to "grey"
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
      url: ApiEndPoints.instan.checkRecordWord,
      body: respModelRecordWorkToJson(data: requestModel),
      context: context,
    );
    context.pop();
    print(">>>>>>>>>>>>>>>>>>>>res>>$res");
    // If the request completes before the timeout, close the loading dialog
    // if (!isTimeout) {
    //   if (Navigator.canPop(context)) {
    //     context.pop();
    //   }
    //   return res.toString();
    // }
    return res.toString();
    // If the request took longer than the timeout, return null as the error dialog is already shown
    return "null";
  }
}
