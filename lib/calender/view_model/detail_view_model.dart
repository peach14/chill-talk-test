import 'dart:developer';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../base/component/dialog_alert.dart';
import '../model/model_carender.dart';

class DetailViewModel extends GetxController {
  void getDataDetail(
      {required DateTime date,
      required List<CalendarEvent> eventsOnTheDate,
      required BuildContext context}) {
    try {
      String type = eventsOnTheDate.first.eventName;
      String title = eventsOnTheDate.last.eventName;
      String? note = eventsOnTheDate.last.note;
      String? firstTime = eventsOnTheDate.last.firstTime;
      String? lastTime = eventsOnTheDate.last.lastTime;
      String? getLastDate =
          eventsOnTheDate.isNotEmpty ? eventsOnTheDate.last.lastDate : null;
      DateTime? firtDate = eventsOnTheDate.last.eventDate;
      print(firstTime);
      print(lastTime);

      final dateFormat = DateFormat('EEEE d MMMM y', 'th');
      final formattedDate = dateFormat.format(eventsOnTheDate.first.eventDate);
      final buddhistYear = firtDate.year + 543;
      String startDate = formattedDate.replaceFirst(
          firtDate.year.toString(), buddhistYear.toString());

      String endDate = '';
      if (getLastDate != null && getLastDate.isNotEmpty) {
        // Parse the date string
        DateTime parsedEndDate = DateFormat("yyyy-MM-dd").parse(getLastDate);

        // Format the parsed date
        //  final dateFormat = DateFormat('EEEE d MMMM y', 'th');
        final formattedLastDate = dateFormat.format(parsedEndDate);

        final lastBuddhistYear = parsedEndDate.year + 543;
        String lastDate = formattedLastDate.replaceFirst(
            parsedEndDate.year.toString(), lastBuddhistYear.toString());
        endDate = lastDate;
      } else {
        // Handle the case where getLastDate is null or empty
        log("No valid last date available");
      }

      if (title == type) {
        type = '';
      }
      print(">>>>>>>>>>>>>>>title ${title}");
      print(">>>>>>>>>>>>>>>type ${type}");
      context.push('/detail',
          extra: ModelCarender(
            type: type,
            title: title,
            date: startDate,
            time: '',
            note: note ?? '',
            lastDate: endDate,
            firstTime: firstTime ?? '',
            lastTime: lastTime ?? '',
          ));
    } catch (e) {
      log(">>>>>>>>>>>>>>>>>>>>$e");
      final dateFormat = DateFormat('EEEE d MMMM y', 'th');
      final formattedDate = dateFormat.format(date);
      final buddhistYear = date.year + 543;
      String dataDate = formattedDate.replaceFirst(
          date.year.toString(), buddhistYear.toString());

      dialogAlert(
        context: context,
        colorButton: CustomColors.errorColor,
        content: const Text("ไม่มีนัดหมาย"),
        titleIcon: Text(dataDate),
        onTap: () {
          context.pop();
        },
      );
    }
  }
}
