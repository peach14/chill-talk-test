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

  Future<String> repoRecordWork({
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

    final res = await Get.find<BaseApiService>().postRequest(
      url: ApiEndPoints.instan.checkRecordWord,
      body: respModelRecordWorkToJson(data: requestModel),
      context: context,
    );
    // ignore: use_build_context_synchronously
    context.pop();

    return res.toString();
  }
}
