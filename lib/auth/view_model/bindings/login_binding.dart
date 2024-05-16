import 'package:get/get.dart';

import '../login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AppViewModel>(() => AppViewModel());

    Get.put<LoginViewModel>(LoginViewModel());
    //   Get.lazyPut<CalenderViewModel>(() => CalenderViewModel());
  }
}
