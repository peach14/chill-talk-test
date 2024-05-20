import 'package:get/get.dart';

import '../../base/service/local_storage/secure_storage_service.dart';
import '../../base/utils/constants/constants.dart';
import '../model/response_login_model.dart';

class DataClientViewModel extends GetxController {
  ResponseModelLogin? data;

  @override
  void onInit() async {
    final getRespLogin = await SecureStorage.instance.read(kResponseLogin);
    final respLogin = responseModelLoginFromJson(getRespLogin ?? '');
    data = respLogin;
    update();
    super.onInit();
  }
}
