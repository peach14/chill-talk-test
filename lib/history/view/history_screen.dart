import 'package:chill_talk_test/base/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/history_view_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put<HistoryViewModel>(HistoryViewModel());

    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                context.pop();
                //  context.pushReplacement(kNevMain);
              },
              child: Image.asset(IconPhat.backButton)),
          title: const Text("ประวัติ", style: TextStyle(fontSize: 20)),
        ),
        body: GetBuilder<HistoryViewModel>(
          builder: (controller) {
            // controller.dateIsToday.isEmpty &&
            //     controller.showGroupedData.isEmpty
            if (controller.status == 1) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text("ไม่พบประวัติของคุณ"),
                ),
              );
            } else if (controller.status == 2) {
              return ListView.builder(
                itemCount: controller.dateIsToday.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                itemBuilder: (context, index) {
                  String date = controller.dateIsToday[index];
                  DateTime parsedDate = DateTime.parse(date);
                  int thaiYear = parsedDate.year + 543;

                  // Predefined map for Thai day abbreviations
                  Map<int, String> thaiDayAbbreviations = {
                    1: 'จ.',
                    2: 'อ.',
                    3: 'พ.',
                    4: 'พฤ.',
                    5: 'ศ.',
                    6: 'ส.',
                    7: 'อา.'
                  };

                  // Get the weekday from parsedDate (1 = Monday, ..., 7 = Sunday)
                  String shortDayOfWeek =
                      thaiDayAbbreviations[parsedDate.weekday] ??
                          ''; // Get the first character

                  String formattedDate =
                      '$shortDayOfWeek ${parsedDate.day}/${parsedDate.month}/$thaiYear';
                  List<String> times = controller.showGroupedData[date]!;

                  DateTime parseTime(String time) {
                    final parts = time.split(':');
                    final hour = int.parse(parts[0]);
                    final minute = int.parse(parts[1]);

                    return DateTime(0, 1, 1, hour, minute);
                  }

                  bool isTimeInRange(
                      DateTime currentTime, String startTime, String endTime) {
                    final start = parseTime(startTime);
                    final end = parseTime(endTime);

                    return (currentTime.isAfter(start) ||
                            currentTime.isAtSameMomentAs(start)) &&
                        (currentTime.isBefore(end) ||
                            currentTime.isAtSameMomentAs(end));
                  }

                  String? morningTime;
                  String? lateMorningTime;
                  String? afternoonTime;
                  String? lateAfternoonTime;
                  String? eveningTime;
                  String? lateEveningTime;

                  for (var time in times) {
                    final parsedTime = parseTime(time);

                    if (isTimeInRange(parsedTime, '05:00', '11:59')) {
                      if (isTimeInRange(parsedTime, '05:00', '08:30')) {
                        morningTime = time;
                      } else {
                        lateMorningTime = time;
                      }
                    } else if (isTimeInRange(parsedTime, '12:00', '13:30')) {
                      if (isTimeInRange(parsedTime, '12:00', '13:00')) {
                        afternoonTime = time;
                      } else {
                        lateAfternoonTime = time;
                      }
                    } else if (isTimeInRange(parsedTime, '17:00', '19:30')) {
                      if (isTimeInRange(parsedTime, '17:00', '19:00')) {
                        eveningTime = time;
                      } else {
                        lateEveningTime = time;
                      }
                    }
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: CustomColors.text3Color, width: 0))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedDate,
                          style: CustomTextStyles.body13,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (lateMorningTime != null)
                              Text(
                                "เข้า(เช้า) : $lateMorningTime น.",
                                style: CustomTextStyles.body14,
                              ),
                            if (morningTime != null)
                              Text(
                                "เข้า(เช้า) : $morningTime น.",
                                style: CustomTextStyles.body15,
                              ),
                            if (lateMorningTime == null && morningTime == null)
                              const Text(
                                "เข้า(เช้า) : -",
                                style: CustomTextStyles.body16,
                              ),
                            if (afternoonTime != null)
                              Text(
                                "เข้า(บ่าย) : $afternoonTime น.",
                                style: CustomTextStyles.body15,
                              ),
                            if (lateAfternoonTime != null)
                              Text(
                                "เข้า(บ่าย) : $lateAfternoonTime น.",
                                style: CustomTextStyles.body14,
                              ),
                            if (lateAfternoonTime == null &&
                                afternoonTime == null)
                              const Text(
                                "เข้า(บ่าย) : -",
                                style: CustomTextStyles.body16,
                              ),
                            //   eveningTime
                            //  lateEveningTime
                            if (eveningTime != null)
                              Text(
                                "ออก : $eveningTime น.",
                                style: CustomTextStyles.body17,
                              ),
                            if (lateEveningTime != null)
                              Text(
                                "ออก : $lateEveningTime น.",
                                style: CustomTextStyles.body14,
                              ),
                            if (lateEveningTime == null && eveningTime == null)
                              const Text(
                                "ออก : -",
                                style: CustomTextStyles.body16,
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    color: CustomColors.primaryColor,
                    backgroundColor:
                        CustomColors.borderColor2, // Corrected "gray" to "grey"
                  ),
                ),
              );
            }
          },
        ));
  }
}
