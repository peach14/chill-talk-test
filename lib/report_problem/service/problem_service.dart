import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/service/base/api_endpoints.dart';
import '../../base/service/base/base_api_service.dart';
import '../model/request_problem_model.dart';

class ProblemService {
  ProblemService._();
  static final instance = ProblemService._();

  Future<String> repoProblem(
      {required BuildContext context,
      required RequestProblemModel requestProblemModel}) async {
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

    // Perform the request
    final res = await Get.find<BaseApiService>().postRequest(
      url: ApiEndPoints.instan.insertProblem,
      body: requestProblemModelToJson(data: requestProblemModel),
      context: context,
    );
    context.pop();
    print(">>>>>>>>>>>>>>>>>>>>res>>$res");

    return res.toString();
  }
}
