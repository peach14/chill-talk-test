import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../base/component/custom_dropdown.dart';
import '../../../base/component/text_form_field_custom.dart';
import '../../base/component/custom_dateTime_call.dart';
import '../../base/component/custom_timeOfDay_call.dart';
import '../../base/component/text_filed_form_details.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/calender_view_model.dart';

class AddNoteScreen extends GetView<CalenderViewModel> {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => context.pop(),
            child: Image.asset(IconPhat.backButton)),
        title: const Text("เพิ่มโน๊ต", style: TextStyle(fontSize: 20)),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => controller.checkEvenCalender(context: context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                        textAlign: TextAlign.center,
                        "บันทึก",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1a6cae),
                            fontWeight: FontWeight.w500)
                        //TextStyle(fontSize: 14),
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 21,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "ประเภท",
                    style: TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        color: Color(0xff1a6cae),
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropDown(
                          onChanged: (value) =>
                              controller.setTypeText(date: value ?? ''),
                          isExpanded: true,
                          item: const ["ลา", "Meeting", "ลากิจ"],
                          direction: DropdownDirection.textDirection,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldCustom(
                    onChanged: (value) {
                      controller.setTitleText(date: value ?? '');
                      return null;
                    },
                    broderColor: Colors.grey.shade400,
                    label: "หัวข้อ",
                    formType: FormType.addNote,
                  ),
                  Obx(
                    () => controller.validTypeTitle.value == false
                        ? const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              "กรุณาเลือกประเภท หรือ ระบุหัวข้อ",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "วันที่",
                        style: TextStyle(
                            height: 1.5,
                            fontSize: 14,
                            color: Color(0xff1a6cae),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Text("ทั้งวัน"),
                          const SizedBox(width: 8),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => controller.setCheckBox(),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Obx(
                                  () => controller.checkBox.value == true
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.blue,
                                        )
                                      : const Icon(
                                          Icons.done,
                                          color: Colors.transparent,
                                        ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Material(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: controller.checkBox.value == true
                                        ? null
                                        : () async {
                                            final DateTime? datetimeStart =
                                                await CustomDateTimeCall
                                                    .instance
                                                    .dateTime(
                                                        context: context,
                                                        initialDate: controller
                                                            .startDate.value,
                                                        helpText:
                                                            'วันที่เริ่มลา',
                                                        onBackground:
                                                            Colors.blue,
                                                        primary: Colors.blue);
                                            if (datetimeStart != null) {
                                              controller.setStartDate(
                                                  date: datetimeStart);
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              final DateTime? datetimeEnd =
                                                  // ignore: use_build_context_synchronously
                                                  await CustomDateTimeCall
                                                      .instance
                                                      .dateTime(
                                                          context: context,
                                                          initialDate:
                                                              controller.endDate
                                                                  .value,
                                                          helpText:
                                                              'วันสุดท้าย',
                                                          onBackground:
                                                              Colors.red,
                                                          primary: Colors.red);
                                              if (datetimeEnd != null) {
                                                controller.setEndDate(
                                                    date: datetimeEnd);
                                              }
                                            }
                                          },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            Text(
                                                "${controller.startDateFormat}"),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text("${controller.endDateFormat}")
                                          ],
                                        ))),
                              )),
                          Obx(() {
                            return Material(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: controller.checkBox.value == true
                                      ? null
                                      : () async {
                                          final TimeOfDay? startTimeOfDay =
                                              await CustomTimeOfDayCall.instance
                                                  .timeOfDay(
                                                      themeColor: Colors.blue,
                                                      initialTime: controller
                                                          .selectStartTime
                                                          .value,
                                                      helpText: 'เวลาเริ่ม',
                                                      context: context);
                                          if (startTimeOfDay != null) {
                                            print(startTimeOfDay.toString());
                                            controller.setStartTime(
                                                time: startTimeOfDay);

                                            await Future.delayed(
                                                const Duration(seconds: 1));

                                            final TimeOfDay? timeOfDayEnd =
                                                // ignore: use_build_context_synchronously
                                                await CustomTimeOfDayCall
                                                    .instance
                                                    .timeOfDay(
                                                        themeColor: Colors.red,
                                                        initialTime: controller
                                                            .selectStartTime
                                                            .value,
                                                        helpText: 'เวลาสิ้นสุด',
                                                        context: context);
                                            if (timeOfDayEnd != null) {
                                              controller.setEndTime(
                                                  date: timeOfDayEnd);
                                            }
                                          }
                                        },
                                  child: controller.checkBox.value == true
                                      ? const SizedBox.shrink()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 8),
                                          child: Column(
                                            children: [
                                              Text(controller
                                                  .showStartTime.value),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(controller.showEndTime.value)
                                            ],
                                          ))),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      return controller.validDate.value == 1
                          ? const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "กรุณาเลือกวันที่",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "โน๊ต",
                    style: TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        color: Color(0xff1a6cae),
                        fontWeight: FontWeight.bold),
                  ),
                  TextFiledFormDetails(
                    onChanged: (String value) {
                      controller.setTextNote(note: value);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
