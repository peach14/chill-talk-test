import 'dart:async';

import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

import '../../auth/model/response_login_model.dart';
import '../../base/component/dialog_alert.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/asset_phat.dart';
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
    Timer.periodic(const Duration(seconds: 1), (_) async {
      time.value = DateFormat('h:mm a').format(await NTP.now());
      _recordAttendWork();
      _recordOutWork();
    });
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(await NTP.now());
    final buddhistYear = DateTime.now().year + 543;
    dates.value = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    await loadLocation();
    super.onInit();
  }

  void _recordAttendWork() async {
    final now = await NTP.now();
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
  void _recordOutWork() async {
    final now = await NTP.now();
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
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
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

      Position position = await permissionLocation();
      // ignore: use_build_context_synchronously
      context.pop();

      final getRespLogin =
          await LocalStorageSecureService.instance.read(kResponseLogin);
      final respLogin = responseModelLoginFromJson(getRespLogin ?? '');
      responseModelLogin = respLogin;
      // ignore: use_build_context_synchronously
      var res = await RecordService.instance.repoRecordWork(
          requestModel: RespModelRecordWork(
              centerCode: respLogin.centerCode,
              userCode: respLogin.userCode,
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString()),
          context: context);
      print(res);
      final response = errorModelRecordFromJson(res);
      switch (response.message) {
        case "Not Work Time":
          response.message = "ขณะนี้ไม่ใช่ เวลา ทำงาน";
          break;
        case "Good jobs":
          response.message = "ทำได้ ดีมาก";
          break;
        case "Your Late":
          response.message = "คุณ มาสาย";
          break;
        case "Have Bad News":
          response.message = "คุณมาสายมาก มี ข่าว ร้าย";
          break;
      }

      if (response.status == 1) {
        // ignore: use_build_context_synchronously
        dialogAlert(
          titleIcon: Image.asset(
            ImagePhat.logoChillTalk,
            scale: 1.5,
          ),
          colorButton: CustomColors.primaryColor,
          context: context,
          content: Text(response.message),
          onTap: () {
            context.pop();
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        dialogAlert(
          titleIcon: Image.asset(
            ImagePhat.logoChillTalk,
            scale: 1.5,
          ),
          colorButton: CustomColors.primaryColor,
          context: context,
          content: Text(response.message),
          onTap: () {
            context.pop();
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      dialogAlert(
        context: context,
        colorButton: CustomColors.primaryColor,
        content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ต"),
        onTap: () {
          context.pop();
          // Reset isDialogShown when dialog is dismissed
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
