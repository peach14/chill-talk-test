import 'package:get/get.dart';

import '../../../auth/view_model/bindings/login_binding.dart';
import '../../../base/config/routing/route.dart';
import '../../../base/service/base/base_api_service.dart';
import '../../../calender/view_model/calender_view_model.dart';
import '../record_work_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AppViewModel>(() => AppViewModel());

    Get.put<AppViewModel>(AppViewModel());
    Get.put<BaseApiService>(BaseApiService());
    Get.put<LoginBinding>(LoginBinding());
    Get.put(AppRouterProvider());
    Get.put<RecordWorkViewModel>(RecordWorkViewModel());

    //   Get.lazyPut<CalenderViewModel>(() => CalenderViewModel());
  }
}
