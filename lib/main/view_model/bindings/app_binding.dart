import 'package:get/get.dart';

import '../app_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppViewModel>(() => AppViewModel());

    //  Get.put<AppViewModel>(AppViewModel());
    //   Get.lazyPut<CalenderViewModel>(() => CalenderViewModel());
  }
}
