// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../base/config/routing/route_path.dart';
// import '../../base/service/local_storage/secure_storage_service.dart';
// import '../../base/utils/constants/constants.dart';
// import '../model/response_login_model.dart';
//
// class SplashViewModel extends GetxController {
//   ResponseModelLogin? response;
//
//   void checkToken({required BuildContext context}) async {
//     await Future.delayed(const Duration(seconds: 2));
//     int myInt = await token();
//     print(myInt);
//     if (myInt == keySuccessToken) {
//       context.go(kNevMain);
//     } else {
//       context.go(kNevLogin);
//     }
//   }
//
//   Future<int> token() async {
//     final getToken = await SecureStorage.instance.getToken();
//     int myInt = int.parse(getToken ?? '');
//     return myInt;
//   }
// }
