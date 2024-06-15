import 'package:chill_talk_test/base/service/local_storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/model/response_login_model.dart';
import '../../base/service/base/base_api_service.dart';
import '../../base/utils/constants/constants.dart';

class HistoryService {
  HistoryService._();
  static final instance = HistoryService._();
  Future<String> repoHistory({required BuildContext context}) async {
    // // Show the loading dialog immediately
    // showDialog(
    //   barrierColor: Colors.transparent,
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) => Center(
    //     child: CircularProgressIndicator(
    //       color: const Color(0xff1a6cae),
    //       backgroundColor: Colors.grey.shade400, // Corrected "gray" to "grey"
    //     ),
    //   ),
    // );

    // History the request

    final getRespLogin =
        await LocalStorageSecureService.instance.read(kResponseLogin);
    final localResp = responseModelLoginFromJson(getRespLogin!);
    // ignore: use_build_context_synchronously
    final res = await Get.find<BaseApiService>().getRequest(
        url:
            // localResp.id == '112' ? '1199900082840' :
            localResp.userCode,
        context: context);
    //context.pop();
    return res.toString();
  }
}
