import 'package:chill_talk_test/auth/view_model/logout_view_model.dart';
import 'package:chill_talk_test/main/view_model/record_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../auth/view_model/data_client_view_model.dart';
import '../../base/component/base_scaffold_main.dart';
import '../../base/component/cal_responsive.dart';
import '../../base/component/custom_bottom_home.dart';
import '../../base/component/custom_button_main.dart';
import '../../base/component/dialog_call.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../history/view_model/history_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put<DataClientViewModel>(DataClientViewModel());
    Get.put<RecordWorkViewModel>(RecordWorkViewModel());
    Get.lazyPut<HistoryViewModel>(() => HistoryViewModel());
    Get.lazyPut<LogoutViewModel>(() => LogoutViewModel());
    // double resize({required double referenceFontSize}) {
    //   double referenceWidth = 360; // Reference screen width in pixels
    //   double screenWidth = MediaQuery.of(context).size.width;
    //   double scalingFactor = referenceFontSize / referenceWidth;
    //   double dynamicFontSize = screenWidth * scalingFactor;
    //   return dynamicFontSize;
    // }

    return BaseScaffoldMain(
      bodyTop: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
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
                                      fontSize: CalResponsive.instance
                                          .scaleWidth(context, 16)),
                                ));
                          },
                          icon: Icon(
                            size:
                                CalResponsive.instance.scaleWidth(context, 24),
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
                        fontSize:
                            CalResponsive.instance.scaleWidth(context, 20),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                GetBuilder<RecordWorkViewModel>(
                  builder: (controller) {
                    return Text(
                      controller.time,
                      style: TextStyle(
                          color: CustomColors.onBackgroundColor,
                          fontSize:
                              CalResponsive.instance.scaleWidth(context, 24),
                          fontWeight: FontWeight.w400),
                    );
                  },
                ),
                SizedBox(
                  height: CalResponsive.instance.scaleHeight(context, 8),
                ),
                GetBuilder<RecordWorkViewModel>(
                  builder: (controller) {
                    return Text("${controller.dates}",
                        style: TextStyle(
                            color: CustomColors.onBackgroundColor,
                            fontSize:
                                CalResponsive.instance.scaleWidth(context, 18),
                            fontWeight: FontWeight.w500));
                  },
                ),
                SizedBox(
                  height: CalResponsive.instance.scaleHeight(context, 8),
                ),
                GetBuilder<DataClientViewModel>(
                  builder: (controller) {
                    return Text(
                        "${controller.data?.name ?? ''} ${controller.data?.surname ?? ''}",
                        style: TextStyle(
                            color: CustomColors.onBackgroundColor,
                            fontSize:
                                CalResponsive.instance.scaleWidth(context, 20),
                            fontWeight: FontWeight.w600));
                  },
                ),
                SizedBox(
                  height: CalResponsive.instance.scaleHeight(context, 8),
                ),
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
                            fontSize:
                                CalResponsive.instance.scaleWidth(context, 14),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: CalResponsive.instance.scaleHeight(context, 127) / 2,
              width: double.infinity,
            )
          ],
        ),
      ),
      bodyCenter: Row(
        children: [
          SizedBox(
            width: CalResponsive.instance.scaleWidth(context, 16),
          ),
          GetBuilder<RecordWorkViewModel>(
            builder: (controller) {
              return CustomBottomHome(
                radius: CalResponsive.instance.scaleWidth(context, 8),
                height: CalResponsive.instance.scaleHeight(context, 127),
                width: CalResponsive.instance.scaleWidth(context, 163.5),
                icon: IconPhat.out1Icon,
                borderColor: controller.disableAttendWork.value == false
                    ? CustomColors.borderColor
                    : CustomColors.primaryColor,
                color: controller.disableAttendWork.value == false
                    ? CustomColors.borderColor
                    : CustomColors.primaryColor,
                textColor: controller.disableAttendWork.value == false
                    ? CustomColors.textColor
                    : CustomColors.onBackgroundColor,
                text: 'บันทึก\nเข้างาน',
                onTap: controller.disableAttendWork.value == false
                    ? null
                    : () => controller.getCurrentLocation(context: context),
                disable: controller.disableAttendWork.value,
                iconSize: CalResponsive.instance.scaleWidth(context, 40),
                fontSize: CalResponsive.instance.scaleWidth(context, 14),
              );
            },
          ),
          SizedBox(
            width: CalResponsive.instance.scaleWidth(context, 16),
          ),
          GetBuilder<RecordWorkViewModel>(
            builder: (controller) {
              return CustomBottomHome(
                radius: CalResponsive.instance.scaleWidth(context, 8),
                height: CalResponsive.instance.scaleHeight(context, 127),
                width: CalResponsive.instance.scaleWidth(context, 163.5),
                disable: controller.disableOutWork.value,
                borderColor: controller.disableOutWork.value == false
                    ? CustomColors.borderColor
                    : CustomColors.primaryColor,
                icon: IconPhat.out2Icon,
                color: controller.disableOutWork.value == false
                    ? CustomColors.borderColor
                    : CustomColors.onBackgroundColor,
                textColor: controller.disableOutWork.value == false
                    ? CustomColors.textColor
                    : CustomColors.primaryColor,
                text: 'บันทึก\nออกงาน',
                onTap: controller.disableOutWork.value == false
                    ? null
                    : () => controller.getCurrentLocation(context: context),
                iconSize: CalResponsive.instance.scaleWidth(context, 40),
                fontSize: CalResponsive.instance.scaleWidth(context, 14),
                // onTap: () =>
                //     controller.logout(context: context),
              );
            },
          ),
          SizedBox(
            width: CalResponsive.instance.scaleWidth(context, 16),
          ),
        ],
      ),
      bodyBottom: Column(
        children: [
          SizedBox(
            height: CalResponsive.instance.scaleHeight(context, 127) / 2,
            width: double.infinity,
          ),
          SizedBox(
            height: CalResponsive.instance.scaleHeight(context, 32),
          ),
          GetBuilder<HistoryViewModel>(
              builder: (controller) => CustomIconButtonMain(
                    onTap: () {
                      controller.loadDataHistory(context);
                      context.push(kNevHistory);
                    },
                    text: 'ประวัติ',
                    icon: IconPhat.frame_32_2,
                    iconSize: CalResponsive.instance.scaleWidth(context, 24),
                    fontSize: CalResponsive.instance.scaleWidth(context, 16),
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
        ],
      ),
    );
  }
}
