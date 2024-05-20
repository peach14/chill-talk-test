import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../auth/model/erroe_model_login.dart';
import '../../base/component/dialog_alert.dart';
import '../model/request_problem_model.dart';
import '../service/problem_service.dart';

class ProblemViewModel extends GetxController {
  void problemSend({required BuildContext context}) async {
    final res = await ProblemService.instance.repoProblem(
        context: context,
        requestProblemModel: RequestProblemModel(
            title: '',
            typeproblem: '',
            detail: '',
            userCode: '',
            centerCode: '',
            problemid: ''));

    final response = errorModelLoginFromJson(res);
    if (response.status == 0) {
      dialogAlert(
        context: context,
        content: Text(response.message),
        colorButton: Colors.red,
        onTap: () {
          // Navigator.pop(context);
          context.pop();
          // Reset isDialogShown when dialog is dismissed
          //  isDialogShown = false;
        },
      );
    } else {
      dialogAlert(
        context: context,
        content: Text(response.message),
        onTap: () {
          context.pop();

          //  Navigator.pop(context);
          // Reset isDialogShown when dialog is dismissed
          //     isDialogShown = false;
        },
      );
      //}
    }
  }
}
