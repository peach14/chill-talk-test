import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalenderViewModel extends GetxController {
  // DateTime date = DateTime(2024, 5, 11);

  static final _today = DateTime.now();
  // DateTime makeDate = DateTime().day;
  static const eventTextStyle =
      TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w400);
  final cellCalendarPageController = CellCalendarPageController();
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
    sampleEvents.add(CalendarEvent(
      eventName: "AAAAAAAAAAAAAAAA",
      eventDate: recordStDate,
      // add(const Duration(days: -42)),
      eventBackgroundColor: Colors.yellow,
      eventTextStyle: eventTextStyle,
    ));
  }

  final sampleEvents = [
    CalendarEvent(
      eventName: "New iPhone",
      eventDate: _today,
      // add(const Duration(days: -42)),
      eventBackgroundColor: Colors.black,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Writing test",
      eventDate: _today.add(const Duration(days: -30)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Play soccer",
      eventDate: _today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.greenAccent,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Learn about history",
      eventDate: _today.add(
        const Duration(days: -7),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Buy new keyboard",
      eventDate: _today.add(
        const Duration(days: -7),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Walk around the park",
      eventDate: _today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Buy a present for Rebecca",
      eventDate: _today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.pink,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Firebase",
      eventDate: _today.add(
        const Duration(days: 7),
      ),
      eventTextStyle: eventTextStyle,
    ),
  ].obs;

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

  @override
  void onReady() {
    sampleEvents;

    super.onReady();
  }
}
