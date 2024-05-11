import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/component/dialog_alert.dart';

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
      if (_position!.latitude > 32.00 && _position!.longitude > -122) {
        dialogAlert(
          context: context,
          content: const Text("not in area"),
          onTap: () {
            Navigator.pop(context);
            // Reset isDialogShown when dialog is dismissed
            isDialogShown = false;
          },
        );
      } else {
        // Get.dialog(
        //   AlertDialog(
        //     title: const Text('success'),
        //     content: const Text('success'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Get.back(); // Close the dialog
        //           isDialogShown = false;
        //         },
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );

        dialogAlert(
          context: context,
          content: const Text("success"),
          onTap: () {
            Navigator.pop(context);
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

// void loadDing() {
//   // Show the loading dialog if checkAuth is false
//   if (mounted) {
//     showDialog(
//       context: context,
//       builder: (context) => Center(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(90),
//           ),
//           child: const Loading(),
//         ),
//       ),
//     );
//   }
//   Future<void> waitAndCloseDialog() async {
//     while (!checkAuth) {
//       await Future.delayed(const Duration(milliseconds: 200));
//     }
//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }
//
//   waitAndCloseDialog();
// }
