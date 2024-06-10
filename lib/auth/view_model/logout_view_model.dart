import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/config/routing/route_path.dart';
import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/constants.dart';

class LogoutViewModel extends GetxController {
  Future<void> logout({required BuildContext context}) async {
    LocalStorageSecureService.instance.deleteToken();
    LocalStorageSecureService.instance.delete(kResponseLogin);
    context.go(kNevDefault);
  }
}
