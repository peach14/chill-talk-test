import 'package:chill_talk_test/main/view_model/record_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/component/base_scaffold_main.dart';
import '../../base/component/custom_bottom_home.dart';
import '../../base/component/custom_button_main.dart';
import '../../base/utils/constants/asset_phat.dart';

class MainScreen extends GetView<RecordWorkViewModel> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldMain(
      bodyTop: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                const Text("หน้าแรก",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const Spacer(
                  flex: 2,
                ),
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
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => Text("${controller.date}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text("กมลพร ชัยเลิศจิต",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 8,
                ),
                Row(
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
                const Spacer(
                  flex: 6,
                ),
              ],
            ),
          ],
        ),
      ),
      bodyCenter: StreamBuilder(
        stream: Stream.value(2),
        builder: (context, snapshot) {
          controller.loadLocation();
          return Row(
            children: [
              const Spacer(),
              CustomBottomHome(
                icon: IconPhat.out1Icon,
                text: 'บันทึก\nเข้างาน',
                onTap: () {
                  controller.getCurrentLocation(context: context);
                },
              ),
              const Spacer(),
              CustomBottomHome(
                icon: IconPhat.out2Icon,
                color: Colors.white,
                textColor: const Color(0xff1a6cae),
                text: 'บันทึก\nออกงาน',
                onTap: () {
                  // setState(() {
                  //   _position = null;
                  // });
                  context.go('/');
                },
              ),
              const Spacer(),
            ],
          );
        },
      ),
      bodyBottom: Expanded(
        flex: 7,
        child: Column(
          children: [
            const Spacer(),
            CustomIconButtonMain(
              onTap: () {
                context.go('/calender');
              },
              text: 'ปฎิทิน',
              icon: IconPhat.calendarToday,
            ),
            CustomIconButtonMain(
              onTap: () {
                context.go('/addNote');
              },
              text: 'แจ้งลา',
              icon: IconPhat.frame_32,
            ),
            CustomIconButtonMain(
              onTap: () {
                context.go('/history');
              },
              text: 'ประวัติ',
              icon: IconPhat.frame_32_2,
            ),
            CustomIconButtonMain(
              onTap: () {
                context.go('/reportProBlem');
              },
              text: 'แจ้งปัญหา',
              icon: (IconPhat.nextWeek),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
