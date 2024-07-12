import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../auth/view_model/data_client_view_model.dart';
import '../../auth/view_model/logout_view_model.dart';
import '../../base/component/custom_bottom_home.dart';
import '../../base/component/custom_button_main.dart';
import '../../base/component/dialog_call.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../history/view_model/history_view_model.dart';
import '../view_model/record_work_view_model.dart';

class MainHorizontalScreen extends GetView<RecordWorkViewModel> {
  const MainHorizontalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put<DataClientViewModel>(DataClientViewModel());
    Get.lazyPut<HistoryViewModel>(() => HistoryViewModel());
    Get.lazyPut<LogoutViewModel>(() => LogoutViewModel());
    double resize({required double referenceFontSize}) {
      double referenceWidth = 360; // Reference screen width in pixels
      double screenWidth = MediaQuery.of(context).size.width;
      double scalingFactor = referenceFontSize / referenceWidth;
      double dynamicFontSize = screenWidth * scalingFactor;
      return dynamicFontSize;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff1568ac), Color(0xffffffff)],
                            begin: Alignment(0.00, -0.4),
                            end: Alignment(0, 2),
                          ),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
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
                                                  controller.logout(
                                                      context: context);
                                                  context.pop();
                                                },
                                                canCle: () {
                                                  context.pop();
                                                },
                                                content: Text(
                                                  "ออกจากระบบ ?",
                                                  style: TextStyle(
                                                      fontSize: resize(
                                                          referenceFontSize:
                                                              16)),
                                                ));
                                          },
                                          icon: Icon(
                                            size: resize(referenceFontSize: 12),
                                            Icons.power_settings_new,
                                            color:
                                                CustomColors.onBackgroundColor,
                                          )),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //     height:
                                    //         MediaQuery.of(context).size.height *
                                    //             0.03),
                                    Text("หน้าแรก",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                resize(referenceFontSize: 12),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: resize(referenceFontSize: 8),
                                    ),
                                    Text(
                                      "${controller.time}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              resize(referenceFontSize: 13),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: resize(referenceFontSize: 2),
                                    ),
                                    Text("${controller.dates}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                resize(referenceFontSize: 9),
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: resize(referenceFontSize: 2),
                                    ),
                                    GetBuilder<DataClientViewModel>(
                                      builder: (controller) {
                                        return Text(
                                            "${controller.data?.name ?? ''} ${controller.data?.surname ?? ''}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: resize(
                                                    referenceFontSize: 9),
                                                fontWeight: FontWeight.w600));
                                      },
                                    ),
                                    SizedBox(
                                      height: resize(referenceFontSize: 2),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(IconPhat.nearMe),
                                        const SizedBox(width: 8),
                                        Text("Chilltalk Co.th",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: resize(
                                                    referenceFontSize: 9),
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    )
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Expanded(
                            flex: 20,
                            child: GetBuilder<HistoryViewModel>(
                                builder: (controller) => CustomIconButtonMain(
                                      onTap: () {
                                        controller.loadDataHistory(context);
                                        context.push(kNevHistory);
                                      },
                                      text: 'ประวัติ',
                                      icon: IconPhat.frame_32_2,
                                      iconSize: 15,
                                      fontSize: 9,
                                    )),
                          ),
                          // const Spacer(flex: 14),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  child: Row(
                    children: [
                      // ipad flex 10
                      const Spacer(flex: 13),
                      Obx(() => Expanded(
                            flex: 20,
                            child: Column(
                              children: [
                                Expanded(
                                  child: FractionallySizedBox(
                                    heightFactor: 0.25,
                                    child: CustomBottomHome(
                                      icon: IconPhat.out1Icon,
                                      borderColor:
                                          controller.disableAttendWork.value ==
                                                  false
                                              ? CustomColors.borderColor
                                              : CustomColors.primaryColor,
                                      color:
                                          controller.disableAttendWork.value ==
                                                  false
                                              ? CustomColors.borderColor
                                              : CustomColors.primaryColor,
                                      textColor:
                                          controller.disableAttendWork.value ==
                                                  false
                                              ? CustomColors.textColor
                                              : CustomColors.onBackgroundColor,
                                      text: 'บันทึก\nเข้างาน',
                                      onTap: controller
                                                  .disableAttendWork.value ==
                                              false
                                          ? null
                                          : () => controller.getCurrentLocation(
                                              context: context),
                                      disable:
                                          controller.disableAttendWork.value,
                                      iconSize: resize(referenceFontSize: 22),
                                      fontSize: resize(referenceFontSize: 8),
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
                                    heightFactor: 0.25,
                                    child: CustomBottomHome(
                                      disable: controller.disableOutWork.value,
                                      borderColor:
                                          controller.disableOutWork.value ==
                                                  false
                                              ? CustomColors.borderColor
                                              : CustomColors.primaryColor,
                                      icon: IconPhat.out2Icon,
                                      color: controller.disableOutWork.value ==
                                              false
                                          ? CustomColors.borderColor
                                          : CustomColors.onBackgroundColor,
                                      textColor:
                                          controller.disableOutWork.value ==
                                                  false
                                              ? CustomColors.textColor
                                              : CustomColors.primaryColor,
                                      text: 'บันทึก\nออกงาน',
                                      onTap: controller.disableOutWork.value ==
                                              false
                                          ? null
                                          : () => controller.getCurrentLocation(
                                              context: context),
                                      iconSize: resize(referenceFontSize: 22),
                                      fontSize: resize(referenceFontSize: 8),
                                      // onTap: () =>
                                      //     controller.logout(context: context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const Spacer(flex: 13),

                      //  const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
