import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/config/routing/route_path.dart';
import '../../base/service/local_storage/secure_storage_service.dart';

class OutWorkViewModel extends GetxController {
  Future<void> logout({required BuildContext context}) async {
    SecureStorage.instance.deleteToken();
    context.go(kNevDefault);
  }
}
