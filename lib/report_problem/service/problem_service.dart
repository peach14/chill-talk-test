import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/service/base/api_endpoints.dart';
import '../../base/service/base/base_api_service.dart';
import '../../base/theme/custom_colors.dart';
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
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: CustomColors.primaryColor,
          backgroundColor:
              CustomColors.borderColor2, // Corrected "gray" to "grey"
        ),
      ),
    );

    // Perform the request
    final res = await Get.find<BaseApiService>().postRequest(
      url: ApiEndPoints.instan.insertProblem,
      body: requestProblemModelToJson(data: requestProblemModel),
      context: context,
    );
    // ignore: use_build_context_synchronously
    context.pop();

    return res.toString();
  }
}
