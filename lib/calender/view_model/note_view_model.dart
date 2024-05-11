import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'calender_view_model.dart';

class NoteViewModel extends GetxController {
  final typeText = ''.obs;
  final startDate = DateTime.now().obs;
  final startDateFormat = ''.obs;
  final sectionText = ''.obs;
  DateTime recordStDate = DateTime.now();
  void setStartDate({required DateTime date}) {
    recordStDate = date;
    startDateFormat.value = DateFormat('EEEE d MMMM y', 'th').format(DateTime(
      date.year + 543,
      date.month,
      date.day,
    ));
  }

  void addEvenDate() {
    final calender = Get.find<CalenderViewModel>();
    calender.sampleEvents.add(CalendarEvent(
      eventName: "AAAAAAAAAAAAAAAA",
      eventDate: recordStDate,
      // add(const Duration(days: -42)),
      eventBackgroundColor: Colors.yellow,
      eventTextStyle: CalenderViewModel.eventTextStyle,
    ));
  }

  @override
  void onInit() {
    startDateFormat.value = DateFormat('EEEE d MMMM y', 'th').format(DateTime(
      DateTime.now().year + 543,
      DateTime.now().month,
      DateTime.now().day,
    ));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
