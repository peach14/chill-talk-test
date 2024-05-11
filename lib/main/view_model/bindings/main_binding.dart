import 'package:chill_talk_test/main/view_model/out_work_view_model.dart';
import 'package:get/get.dart';

import '../record_work_view_model.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MainViewModel>(() => MainViewModel());

    Get.put<RecordWorkViewModel>(RecordWorkViewModel());
    Get.lazyPut<OutWorkViewModel>(() => OutWorkViewModel());
  }
}
