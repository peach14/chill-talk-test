import 'package:get/get.dart';

import '../record_work_view_model.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MainViewModel>(() => MainViewModel());

    Get.put<RecordWorkViewModel>(RecordWorkViewModel());
  }
}
