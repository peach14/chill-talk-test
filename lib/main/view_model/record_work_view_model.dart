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
import '../model/request_record_model.dart';
import '../service/record_work_service.dart';

class RecordWorkViewModel extends GetxController {
  Position? _position;
  bool isDialogShown = false;
  final date = DateFormat('EEEE d MMMM y', 'th')
      .format(DateTime(
        DateTime.now().year + 543,
        DateTime.now().month,
        DateTime.now().day,
      ))
      .obs;
  final time = DateFormat('h:mm a').format(DateTime.now()).obs;

  void getCurrentLocation({required BuildContext context}) async {
    // Ensure that dialog is not already shown
    if (isDialogShown) return;
    // Set isDialogShown to true to prevent multiple dialogs from being shown
    isDialogShown = true;

    print(">>>>>>>>>>>> : $_position");

    if (_position != null) {
      final getRespLogin = await SecureStorage.instance.read(kResponseLogin);
      final respLogin = responseModelLoginFromJson(getRespLogin ?? '');
      final res = await RecordService.instance.recordWork(
          requestModel: RespModelRecordWork(
              centerCode: respLogin.centerCode,
              userCode: respLogin.userCode,
              latitude: _position!.latitude.toString(),
              longitude: _position!.longitude.toString()),
          context: context);
      print(res);
      //  final response = errorModelLoginFromJson(res);
      print(respLogin.centerCode);
      print(respLogin.userCode);
      print(_position!.latitude.toString());
      print(_position!.longitude.toString());
      if (2 == 1) {
        dialogAlert(
          context: context,
          content: Text("response.message"),
          onTap: () {
            // Navigator.pop(context);
            context.pop();
            // Reset isDialogShown when dialog is dismissed
            isDialogShown = false;
          },
        );
      } else {
        dialogAlert(
          context: context,
          content: const Text("success"),
          onTap: () {
            context.pop();

            //  Navigator.pop(context);
            // Reset isDialogShown when dialog is dismissed
            isDialogShown = false;
          },
        );
        //}
      }
    }
    print(_position);
    // Reset isDialogShown when the function completes
    isDialogShown = false;
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

  void loadLocation() async {
    Position position = await permissionLocation();

    _position = position;
  }

  @override
  void onInit() {
    loadLocation();
    Timer.periodic(const Duration(seconds: 1), (_) {
      time.value = DateFormat('h:mm a').format(DateTime.now());
    });
    super.onInit();
  }
}
