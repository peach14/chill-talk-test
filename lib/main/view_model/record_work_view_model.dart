import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../auth/model/response_login_model.dart';
import '../../base/component/dialog_alert.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/constants.dart';
import '../model/erroe_model_record.dart';
import '../model/request_record_model.dart';
import '../service/record_work_service.dart';

class RecordWorkViewModel extends GetxController {
  ResponseModelLogin? responseModelLogin;

  // Format the current date using the Thai Buddhist calendar
  final date = "".obs;

  final time = DateFormat('h:mm a').format(DateTime.now()).obs;

  void getCurrentLocation({required BuildContext context}) async {
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

    Position position = await permissionLocation();
    // ignore: use_build_context_synchronously
    context.pop();

    final getRespLogin = await SecureStorage.instance.read(kResponseLogin);
    final respLogin = responseModelLoginFromJson(getRespLogin ?? '');
    responseModelLogin = respLogin;
    // ignore: use_build_context_synchronously
    final res = await RecordService.instance.repoRecordWork(
        requestModel: RespModelRecordWork(
            centerCode: respLogin.centerCode,
            userCode: respLogin.userCode,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString()),
        context: context);

    final response = errorModelRecordFromJson(res);
    if (response.status == 1) {
      // ignore: use_build_context_synchronously
      dialogAlert(
        colorButton: Colors.red,
        context: context,
        content: Text(response.message),
        onTap: () {
          context.pop();
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        content: Text(response.message),
        onTap: () {
          context.pop();
        },
      );
    }
  }

  Future<Position> permissionLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Error: Location Permission are denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> loadLocation() async {
    Position position = await permissionLocation();

    return position;
  }

  @override
  void onInit() async {
    await loadLocation();
    Timer.periodic(const Duration(seconds: 1), (_) {
      time.value = DateFormat('h:mm a').format(DateTime.now());
    });
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(DateTime.now());
    final buddhistYear = DateTime.now().year + 543;
    date.value = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    super.onInit();
  }
}
