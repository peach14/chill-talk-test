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
  final dates = "".obs;

  final time = DateFormat('h:mm a').format(DateTime.now()).obs;
  final disableAttendWork = true.obs;
  @override
  void onInit() async {
    _recordAttendWork();
    _recordOutWork();
    Timer.periodic(const Duration(seconds: 1), (_) {
      time.value = DateFormat('h:mm a').format(DateTime.now());
      _recordAttendWork();
      _recordOutWork();
    });
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(DateTime.now());
    final buddhistYear = DateTime.now().year + 543;
    dates.value = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    await loadLocation();
    super.onInit();
  }

  void _recordAttendWork() {
    final now = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(now);
    final morningStart = DateTime(0, 1, 1, 05, 00);
    final morningEnd = DateTime(0, 1, 1, 13, 31);
    // final middayStart = DateTime(0, 1, 1, 12, 00);
    // final middayEnd = DateTime(0, 1, 1, 13, 30);

    final parsedCurrentTime = _parseTime(currentTime);

    if ((parsedCurrentTime.isAfter(morningStart) ||
            parsedCurrentTime.isAtSameMomentAs(morningStart)) &&
        (parsedCurrentTime.isBefore(morningEnd) ||
            parsedCurrentTime.isAtSameMomentAs(morningEnd))) {
      disableAttendWork.value = true;
    } else {
      disableAttendWork.value = false;
    }
  }

  final disableOutWork = true.obs;
  void _recordOutWork() {
    final now = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(now);
    final eveningStart = DateTime(0, 1, 1, 17, 00);
    final eveningEnd = DateTime(0, 1, 1, 19, 30);

    final parsedCurrentTime = _parseTime(currentTime);

    if ((parsedCurrentTime.isAfter(eveningStart) ||
            parsedCurrentTime.isAtSameMomentAs(eveningStart)) &&
        (parsedCurrentTime.isBefore(eveningEnd) ||
            parsedCurrentTime.isAtSameMomentAs(eveningEnd))) {
      disableOutWork.value = true;
    } else {
      disableOutWork.value = false;
    }
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(0, 1, 1, hour, minute);
  }

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

    final getRespLogin =
        await LocalStorageSecureService.instance.read(kResponseLogin);
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
        colorButton: const Color(0xff1a6cae),
        context: context,
        content: Text(response.message),
        onTap: () {
          context.pop();
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        colorButton: const Color(0xff1a6cae),
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
}
