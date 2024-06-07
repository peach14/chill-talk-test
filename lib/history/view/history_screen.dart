import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/config/routing/route_path.dart';
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
                context.pushReplacement(kNevMain);
              },
              child: Image.asset(IconPhat.backButton)),
          title: const Text("ประวัติ", style: TextStyle(fontSize: 20)),
        ),
        body: GetBuilder<HistoryViewModel>(
          builder: (controller) {
            return controller.dateIsToday.isEmpty &&
                    controller.showGroupedData.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(
                        color: const Color(0xff1a6cae),
                        backgroundColor:
                            Colors.grey.shade400, // Corrected "gray" to "grey"
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.dateIsToday.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
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
                      String? morningTime;
                      String? lateMorningTime;
                      String? afternoonTime;
                      String? lateAfternoonTime;
                      String? eveningTime;
                      String? lateEveningTime;
                      List<String> times = controller.showGroupedData[date]!;

                      DateTime parseTime(String time) {
                        final parts = time.split(':');
                        final hour = int.parse(parts[0]);
                        final minute = int.parse(parts[1]);

                        return DateTime(0, 0, 0, hour, minute);
                      }

                      bool isTimeInRange(DateTime currentTime, String startTime,
                          String endTime) {
                        final start = parseTime(startTime);
                        final end = parseTime(endTime);

                        return (currentTime.isAfter(start) ||
                                currentTime.isAtSameMomentAs(start)) &&
                            (currentTime.isBefore(end) ||
                                currentTime.isAtSameMomentAs(end));
                      }

                      for (var time in times) {
                        final parsedTime = parseTime(time);

                        if (isTimeInRange(parsedTime, '05:00', '11:59')) {
                          if (isTimeInRange(parsedTime, '05:00', '08:30')) {
                            morningTime = time;
                          } else {
                            lateMorningTime = time;
                          }
                        } else if (isTimeInRange(
                            parsedTime, '12:00', '13:30')) {
                          if (isTimeInRange(parsedTime, '12:00', '13:00')) {
                            afternoonTime = time;
                          } else {
                            lateAfternoonTime = time;
                          }
                        } else if (isTimeInRange(
                            parsedTime, '17:00', '19:30')) {
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
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (lateMorningTime != null)
                                  Text(
                                    "เข้า(เช้า) : $lateMorningTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xfff40201)),
                                  ),
                                if (morningTime != null)
                                  Text(
                                    "เข้า(เช้า) : $morningTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.green),
                                  ),
                                if (lateMorningTime == null &&
                                    morningTime == null)
                                  const Text(
                                    "เข้า(เช้า) : -",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xffBDBDBD)),
                                  ),
                                if (afternoonTime != null)
                                  Text(
                                    "เข้า(บ่าย) : $afternoonTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.green),
                                  ),
                                if (lateAfternoonTime != null)
                                  Text(
                                    "เข้า(บ่าย) : $lateAfternoonTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xfff40201)),
                                  ),
                                if (lateAfternoonTime == null &&
                                    afternoonTime == null)
                                  const Text(
                                    "เข้า(บ่าย) : -",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xffBDBDBD)),
                                  ),
                                //   eveningTime
                                //  lateEveningTime
                                if (eveningTime != null)
                                  Text(
                                    "ออก : $eveningTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.blue),
                                  ),
                                if (lateEveningTime != null)
                                  Text(
                                    "ออก : $lateEveningTime น.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xfff40201)),
                                  ),
                                if (lateEveningTime == null &&
                                    eveningTime == null)
                                  const Text(
                                    "ออก : -",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xffBDBDBD)),
                                  ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
