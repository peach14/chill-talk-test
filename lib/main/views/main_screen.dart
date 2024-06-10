import 'package:chill_talk_test/auth/view_model/logout_view_model.dart';
import 'package:chill_talk_test/main/view_model/record_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../auth/view_model/data_client_view_model.dart';
import '../../base/component/base_scaffold_main.dart';
import '../../base/component/custom_bottom_home.dart';
import '../../base/component/custom_button_main.dart';
import '../../base/component/dialog_call.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../history/view_model/history_view_model.dart';

class MainScreen extends GetView<RecordWorkViewModel> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<DataClientViewModel>(DataClientViewModel());
    Get.lazyPut<HistoryViewModel>(() => HistoryViewModel());
    Get.lazyPut<LogoutViewModel>(() => LogoutViewModel());

    return BaseScaffoldMain(
      bodyTop: SafeArea(
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //   const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 27),
                GetBuilder<LogoutViewModel>(
                  builder: (controller) => IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        dialogCall(
                            context: context,
                            conferm: () {
                              controller.logout(context: context);
                              context.pop();
                            },
                            canCle: () {
                              context.pop();
                            },
                            content: const Text("ออกจากระบบ ?"));
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Color(0xfff40201),
                      )),
                ),
                const Spacer()
              ],
            ),

            const Text("หน้าแรก",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const Spacer(flex: 2),
            Obx(
              () {
                return Text(
                  "${controller.time}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                );
              },
            ),
            const SizedBox(height: 8),
            Obx(
              () => Text("${controller.dates}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 8),
            GetBuilder<DataClientViewModel>(
              builder: (controller) {
                return Text(
                    "${controller.data?.name ?? ''} ${controller.data?.surname ?? ''}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600));
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconPhat.nearMe),
                const SizedBox(
                  width: 8,
                ),
                const Text("Chilltalk Co.th",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
      bodyCenter: Row(
        children: [
          const Spacer(),
          Obx(() => CustomBottomHome(
                icon: IconPhat.out1Icon,
                borderColor: controller.disableAttendWork.value == false
                    ? Colors.grey.shade300
                    : const Color(0xff1a6cae),
                color: controller.disableAttendWork.value == false
                    ? Colors.grey.shade300
                    : const Color(0xff1a6cae),
                textColor: controller.disableAttendWork.value == false
                    ? Colors.grey.shade500
                    : Colors.white,
                text: 'บันทึก\nเข้างาน',
                onTap: controller.disableAttendWork.value == false
                    ? null
                    : () => controller.getCurrentLocation(context: context),
                disable: controller.disableAttendWork.value,
              )),
          const Spacer(),
          //  Color(0xffBDBDBD)
          Obx(() => CustomBottomHome(
                disable: controller.disableOutWork.value,
                borderColor: controller.disableOutWork.value == false
                    ? Colors.grey.shade300
                    : const Color(0xff1a6cae),
                icon: IconPhat.out2Icon,
                color: controller.disableOutWork.value == false
                    ? Colors.grey.shade300
                    : Colors.white,
                textColor: controller.disableOutWork.value == false
                    ? Colors.grey.shade500 //const Color(0xffBDBDBD)
                    : const Color(0xff1a6cae),
                text: 'บันทึก\nออกงาน',
                onTap: controller.disableOutWork.value == false
                    ? null
                    : () => controller.getCurrentLocation(context: context),
                // onTap: () =>
                //     controller.logout(context: context),
              )),
          const Spacer(),
        ],
      ),
      bodyBottom: Expanded(
        flex: 7,
        child: Column(
          children: [
            const Spacer(),
            CustomIconButtonMain(
              onTap: null,
              //     () {
              //   context.pushReplacement(kNevCalender);
              // },
              text: 'ปฎิทิน',
              icon: IconPhat.calendarToday,
            ),
            CustomIconButtonMain(
              onTap: null,
              //     () {
              //   context.push(kNevAddNote);
              // },
              text: 'แจ้งลา',
              icon: IconPhat.frame_32,
            ),
            GetBuilder<HistoryViewModel>(
                builder: (controller) => CustomIconButtonMain(
                      onTap: () {
                        controller.loadDataHistory(context);
                        context.pushReplacement(kNevHistory);
                      },
                      text: 'ประวัติ',
                      icon: IconPhat.frame_32_2,
                    )),
            CustomIconButtonMain(
              onTap: null,
              //     () {
              //   context.pushReplacement(kNevReportProBlem);
              // },
              text: 'แจ้งปัญหา',
              icon: (IconPhat.nextWeek),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
