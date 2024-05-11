import 'package:chill_talk_test/calender/view_model/calender_view_model.dart';
import 'package:get/get.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MainViewModel>(() => MainViewModel());

    Get.put<CalenderViewModel>(CalenderViewModel());
    //   Get.lazyPut<CalenderViewModel>(() => CalenderViewModel());
  }
}
