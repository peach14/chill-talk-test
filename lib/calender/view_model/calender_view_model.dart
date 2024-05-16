import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppViewModel extends GetxController {
  static final _today = DateTime.now();

  // set Start Date
  final startDate = DateTime.now().obs;
  final startDateFormat = ''.obs;
  DateTime recordStDate = DateTime.now();
  void setStartDate({required DateTime date}) {
    recordStDate = date;
    startDateFormat.value = DateFormat('EEEE d MMMM y', 'th').format(DateTime(
      date.year + 543,
      date.month,
      date.day,
    ));
  }

  //set Type Text
  String typeText = '';
  void setTypeText({required String date}) {
    typeText = date;
  }

  //set title Text
  String titleText = '';
  void setTitleText({required String date}) {
    titleText = date;
  }

  // view calender
  final cellCalendarPageController = CellCalendarPageController();
  static const eventTextStyle =
      TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w400);
  List<CalendarEvent> sampleEvents = [
    CalendarEvent(
      eventName: "Writing test",
      eventDate: _today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    ),
  ];

  @override
  void onInit() {
    sampleEvents;
    startDateFormat.value = DateFormat('EEEE d MMMM y', 'th').format(DateTime(
      DateTime.now().year + 543,
      DateTime.now().month,
      DateTime.now().day,
    ));
    super.onInit();
  }

// Add Date
  void addEvenDate() {
    if (typeText.isNotEmpty && titleText.isEmpty) {
      sampleEvents.add(CalendarEvent(
        eventName: typeText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.blueAccent,
        eventTextStyle: eventTextStyle,
      ));
    } else if (typeText.isEmpty && titleText.isNotEmpty) {
      sampleEvents.add(CalendarEvent(
        eventName: titleText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.amberAccent,
        eventTextStyle: eventTextStyle,
      ));
    } else if (typeText.isNotEmpty && titleText.isNotEmpty) {
      sampleEvents.add(CalendarEvent(
        eventName: typeText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.blueAccent,
        eventTextStyle: eventTextStyle,
      ));
      sampleEvents.add(CalendarEvent(
        eventName: titleText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.amberAccent,
        eventTextStyle: eventTextStyle,
      ));
    } else {
      return;
    }

    update();
  }

  // set dispod
  void setDispod() {
    recordStDate = DateTime.now();
    typeText = '';
    titleText = '';
    startDateFormat.value = DateFormat('EEEE d MMMM y', 'th').format(DateTime(
      DateTime.now().year + 543,
      DateTime.now().month,
      DateTime.now().day,
    ));
  }

  @override
  void onClose() {
    recordStDate = DateTime.now();
    typeText = '';
    titleText = '';
    super.onClose();
  }
}
