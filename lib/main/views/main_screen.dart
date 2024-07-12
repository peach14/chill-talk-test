import 'package:chill_talk_test/auth/view_model/logout_view_model.dart';
import 'package:chill_talk_test/main/view_model/record_work_view_model.dart';
import 'package:chill_talk_test/main/views/main_horizontal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../auth/view_model/data_client_view_model.dart';
import '../../base/component/base_scaffold_main.dart';
import '../../base/component/custom_bottom_home.dart';
import '../../base/component/custom_button_main.dart';
import '../../base/component/dialog_call.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../history/view_model/history_view_model.dart';

class MainScreen extends GetView<RecordWorkViewModel> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<DataClientViewModel>(DataClientViewModel());
    Get.lazyPut<HistoryViewModel>(() => HistoryViewModel());
    Get.lazyPut<LogoutViewModel>(() => LogoutViewModel());
    final responsive = ResponsiveWrapper.of(context).isMobile;
    double resize({required double referenceFontSize}) {
      double referenceWidth = 360; // Reference screen width in pixels
      double screenWidth = MediaQuery.of(context).size.width;
      double scalingFactor = referenceFontSize / referenceWidth;
      double dynamicFontSize = screenWidth * scalingFactor;
      return dynamicFontSize;
    }

    print(responsive);
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return orientation == Orientation.portrait
            ? BaseScaffoldMain(
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
                                      confirm: () {
                                        controller.logout(context: context);
                                        context.pop();
                                      },
                                      canCle: () {
                                        context.pop();
                                      },
                                      content: Text(
                                        "ออกจากระบบ ?",
                                        style: TextStyle(
                                            fontSize:
                                                resize(referenceFontSize: 16)),
                                      ));
                                },
                                icon: Icon(
                                  size: resize(referenceFontSize: 24),
                                  Icons.power_settings_new,
                                  color: CustomColors.onBackgroundColor,
                                )),
                          ),
                          const Spacer()
                        ],
                      ),

                      Text("หน้าแรก",
                          style: TextStyle(
                              color: CustomColors.onBackgroundColor,
                              fontSize: resize(referenceFontSize: 20),
                              fontWeight: FontWeight.bold)),
                      const Spacer(flex: 2),
                      Obx(
                        () {
                          return Text(
                            "${controller.time}",
                            style: TextStyle(
                                color: CustomColors.onBackgroundColor,
                                fontSize: resize(referenceFontSize: 24),
                                fontWeight: FontWeight.w400),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text("${controller.dates}",
                            style: TextStyle(
                                color: CustomColors.onBackgroundColor,
                                fontSize: resize(referenceFontSize: 18),
                                fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<DataClientViewModel>(
                        builder: (controller) {
                          return Text(
                              "${controller.data?.name ?? ''} ${controller.data?.surname ?? ''}",
                              style: TextStyle(
                                  color: CustomColors.onBackgroundColor,
                                  fontSize: resize(referenceFontSize: 20),
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
                          Text("Chilltalk Co.th",
                              style: TextStyle(
                                  color: CustomColors.onBackgroundColor,
                                  fontSize: resize(referenceFontSize: 14),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const Spacer(flex: 6),
                    ],
                  ),
                ),
                bodyCenter: Row(
                  children: [
                    // ipad flex 10
                    Spacer(flex: responsive ? 2 : 6),
                    Obx(() => Expanded(
                          flex: 20,
                          child: Column(
                            children: [
                              Expanded(
                                child: FractionallySizedBox(
                                  heightFactor: responsive ? 0.156 : 0.18,
                                  child: CustomBottomHome(
                                    icon: IconPhat.out1Icon,
                                    borderColor:
                                        controller.disableAttendWork.value ==
                                                false
                                            ? CustomColors.borderColor
                                            : CustomColors.primaryColor,
                                    color: controller.disableAttendWork.value ==
                                            false
                                        ? CustomColors.borderColor
                                        : CustomColors.primaryColor,
                                    textColor:
                                        controller.disableAttendWork.value ==
                                                false
                                            ? CustomColors.textColor
                                            : CustomColors.onBackgroundColor,
                                    text: 'บันทึก\nเข้างาน',
                                    onTap: controller.disableAttendWork.value ==
                                            false
                                        ? null
                                        : () => controller.getCurrentLocation(
                                            context: context),
                                    disable: controller.disableAttendWork.value,
                                    iconSize: resize(referenceFontSize: 40),
                                    fontSize: resize(referenceFontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    //   const Spacer(),
                    //  Color(0xffBDBDBD)
                    const Spacer(flex: 2),

                    Obx(() => Expanded(
                          flex: 20,
                          child: Column(
                            children: [
                              Expanded(
                                child: FractionallySizedBox(
                                  heightFactor: responsive ? 0.156 : 0.18,
                                  child: CustomBottomHome(
                                    disable: controller.disableOutWork.value,
                                    borderColor:
                                        controller.disableOutWork.value == false
                                            ? CustomColors.borderColor
                                            : CustomColors.primaryColor,
                                    icon: IconPhat.out2Icon,
                                    color:
                                        controller.disableOutWork.value == false
                                            ? CustomColors.borderColor
                                            : CustomColors.onBackgroundColor,
                                    textColor:
                                        controller.disableOutWork.value == false
                                            ? CustomColors.textColor
                                            : CustomColors.primaryColor,
                                    text: 'บันทึก\nออกงาน',
                                    onTap: controller.disableOutWork.value ==
                                            false
                                        ? null
                                        : () => controller.getCurrentLocation(
                                            context: context),
                                    iconSize: resize(referenceFontSize: 40),
                                    fontSize: resize(referenceFontSize: 14),
                                    // onTap: () =>
                                    //     controller.logout(context: context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Spacer(flex: responsive ? 2 : 6),

                    //  const Spacer(),
                  ],
                ),
                bodyBottom: Column(
                  children: [
                    const Spacer(),
                    GetBuilder<HistoryViewModel>(
                        builder: (controller) => CustomIconButtonMain(
                              onTap: () {
                                controller.loadDataHistory(context);
                                context.push(kNevHistory);
                              },
                              text: 'ประวัติ',
                              icon: IconPhat.frame_32_2,
                              iconSize: 24,
                              fontSize: 16,
                            )),

                    // CustomIconButtonMain(
                    //   onTap: null,
                    //   //     () {
                    //   //   context.pushReplacement(kNevCalender);
                    //   // },
                    //   text: 'ปฎิทิน',
                    //   icon: IconPhat.calendarToday,
                    // ),
                    // CustomIconButtonMain(
                    //   onTap: null,
                    //   //     () {
                    //   //   context.push(kNevAddNote);
                    //   // },
                    //   text: 'แจ้งลา',
                    //   icon: IconPhat.frame_32,
                    // ),
                    // GetBuilder<HistoryViewModel>(
                    //     builder: (controller) => CustomIconButtonMain(
                    //           onTap: () {
                    //             controller.loadDataHistory(context);
                    //             context.push(kNevHistory);
                    //           },
                    //           text: 'ประวัติ',
                    //           icon: IconPhat.frame_32_2,
                    //         )),
                    // CustomIconButtonMain(
                    //   onTap: null,
                    //   //     () {
                    //   //   context.pushReplacement(kNevReportProBlem);
                    //   // },
                    //   text: 'แจ้งปัญหา',
                    //   icon: (IconPhat.nextWeek),
                    // ),
                    const Spacer(flex: 2),
                  ],
                ),
              )
            : const MainHorizontalScreen();
      },
    );
  }
}
