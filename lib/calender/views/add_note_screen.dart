import 'package:chill_talk_test/base/component/custom_time.dart';
import 'package:chill_talk_test/calender/view_model/calender_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../base/component/custom_dropdown.dart';
import '../../../base/component/text_form_field_custom.dart';
import '../../base/component/text_filed_form_details.dart';
import '../../base/utils/constants/asset_phat.dart';

class AddNoteScreen extends GetView<CalenderViewModel> {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectTime = TimeOfDay.now();
    bool checkBox = false;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            // radius: ,
            borderRadius: BorderRadius.circular(50),

            // borderRadius: BorderRadius.all(Radius.zero),
            onTap: () {
              Navigator.pop(context);
            },
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
                onTap: () {
                  //  controller.addEvenDate();
                  //  controller.loadDataCalender();
                  controller.checkEvenCalender();
                  context.pop();
                },
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
                          onChanged: (value) {
                            controller.setTypeText(date: value ?? '');
                            print(value);
                          },
                          isExpanded: true,
                          item: const ["asdas", "asdasd", "asd"],
                          direction: DropdownDirection.textDirection,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldCustom(
                    onChanged: (value) {
                      controller.setTitleText(date: value ?? '');

                      print(value);
                      return null;
                    },
                    broderColor: Colors.grey.shade400,
                    label: "หัวข้อ",
                  ),
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
                            onTap: () {
                              // setState(() {
                              //   checkBox = !checkBox;
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(50)),
                              child: checkBox
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.blue,
                                    )
                                  : const Icon(
                                      Icons.done,
                                      color: Colors.transparent,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  //  DateTime selectDate = DateTime.now();

                                  final DateTime? datetime =
                                      await showDatePicker(
                                          confirmText: "ตกลง",
                                          cancelText: 'ยกเลิก',
                                          context: context,
                                          helpText: 'วันที่เริ่มลา',
                                          locale: const Locale('th'),
                                          initialDate:
                                              controller.startDate.value,
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  onBackground: Colors.blue,
                                                  primary: Colors
                                                      .blue, // Header background color
                                                  onPrimary: Colors
                                                      .white, // Header text color
                                                  onSurface: Colors
                                                      .black, // Body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors
                                                        .black, // Button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));
                                  if (datetime != null) {
                                    // setState(() {
                                    //   selectDate = datetime;
                                    // });

                                    // formattedDate = formattedDate.replaceAll(
                                    //     selectDate.year.toString(),
                                    //     selectDate.toString());
                                    controller.setStartDate(date: datetime);
                                    // controllers.startDate.value =
                                    //     datetime;

                                    await Future.delayed(
                                        const Duration(seconds: 1));

                                    final DateTime? datetimeEnd =
                                        await showDatePicker(
                                      confirmText: "ตกลง",
                                      cancelText: 'ยกเลิก',
                                      context: context,
                                      helpText: 'วันสุดท้าย',
                                      initialDate: controller.endDate.value,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(3000),
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              onBackground: Colors.red,
                                              primary: Colors
                                                  .red, // Header background color
                                              onPrimary: Colors
                                                  .white, // Header text color
                                              onSurface: Colors
                                                  .black, // Body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors
                                                    .black, // Button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (datetimeEnd != null) {
                                      controller.setEndDate(date: datetimeEnd);
                                    }
                                  }
                                },
                                child: Obx(() {
                                  return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          Text("${controller.startDateFormat}"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text("${controller.endDateFormat}")
                                        ],
                                      ));
                                })),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  final TimeOfDay? timeOfDay =
                                      await customShowTimePicker(
                                    hourLabelText: "ชั่วโมง",
                                    minuteLabelText: "นาที",
                                    context: context,
                                    initialTime: selectTime,
                                    barrierDismissible: false,
                                    helpText: 'เวลาเริ่ม',
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Colors
                                                .blue, // Header background color
                                            onPrimary: Colors
                                                .white, // Header text color
                                            onSurface:
                                                Colors.black, // Body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors
                                                  .black, // Button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    initialEntryMode:
                                        CustomTimePickerEntryMode.dial,
                                  );
                                  if (timeOfDay != null) {
                                    // setState(() {
                                    //   selectTime = timeOfDay;
                                    //   String formattedTime =
                                    //       '${selectTime.hour}:${selectTime.minute.toString().padLeft(2, '0')}';
                                    //   print(
                                    //       '>>>>>>>>>>>>>>>>>>>>>>Selected Time: $formattedTime');
                                    // });

                                    await Future.delayed(
                                        const Duration(seconds: 1));

                                    final TimeOfDay? timeOfDayEnd =
                                        await customShowTimePicker(
                                            context: context,
                                            initialTime: selectTime,
                                            helpText: 'เวลาสิ้นสุด',
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data:
                                                    ThemeData.light().copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary: Colors
                                                        .red, // Header background color
                                                    onPrimary: Colors
                                                        .white, // Header text color
                                                    onSurface: Colors
                                                        .black, // Body text color
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors
                                                          .black, // Button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                            initialEntryMode:
                                                CustomTimePickerEntryMode.dial);
                                    if (timeOfDayEnd != null) {
                                      //   setState(() {
                                      //     selectTime = timeOfDayEnd;
                                      //   });
                                    }
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8),
                                    child: const Column(
                                      children: [
                                        Text("13.00"),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("13.00")
                                      ],
                                    ))),
                          )
                        ],
                      ),
                    ),
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
