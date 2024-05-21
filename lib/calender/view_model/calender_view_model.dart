import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../service/data_calender.dart';

class CalenderViewModel extends GetxController {
  static final _today = DateTime.now();
  DateTime testEndDate = DateTime.now();
  DateTime testStartDate = DateTime.now();

  @override
  void onInit() {
    loadDataCalender();
    sampleEvents;
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(DateTime.now());
    final buddhistYear = DateTime.now().year + 543;
    String dataDate = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    startDateFormat.value = dataDate;
    endDateFormat.value = dataDate;
    super.onInit();
  }

  @override
  void onClose() {
    recordStDate = DateTime.now();
    typeText = '';
    titleText = '';
    super.onClose();
  }

  // set Date_Appbar
  final dateAppbar = ''.obs;
  void setDateAppBar({required DateTime date}) {
    // Define the format for month only
    final DateFormat monthFormat = DateFormat('MMMM', 'th');
    String thaiMonth = monthFormat.format(date);
    int buddhistYear = date.year + 543;
    String dataDate = '$thaiMonth $buddhistYear';
    dateAppbar.value = dataDate;
  }

  // set Start Date
  final startDate = DateTime.now().obs;
  final startDateFormat = ''.obs;
  DateTime recordStDate = DateTime.now();
  void setStartDate({required DateTime date}) {
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(date);
    final buddhistYear = date.year + 543;
    String dataDate = formattedDate.replaceFirst(
        date.year.toString(), buddhistYear.toString());
    startDateFormat.value = dataDate;
    recordStDate = date;
    testStartDate = date;
    print("date>>>>>>>>>>>>>>>>>>>>>>>>>$date");
    print("date>>>>>>>>>>>>>>>>>>>>>>>>>$dataDate");
  }

  // set end Date
  final endDate = DateTime.now().obs;
  final endDateFormat = ''.obs;
  void setEndDate({required DateTime date}) {
    print(date);
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(date);
    final buddhistYear = date.year + 543;
    String dataDate = formattedDate.replaceFirst(
        date.year.toString(), buddhistYear.toString());
    endDateFormat.value = dataDate;
    testEndDate = date;
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

  //set Text note
  String textNote = '';
  void setTextNote({required String note}) {
    textNote = note;
  }

  // view calender
  void loadDataCalender() {
    sampleEvents.clear();
    final getDataJson = DaDtaCalender.instance.dataCalender;
    final dataCalender = calenderTestModelFromJson(getDataJson);
// Convert each CalenderTestModel to a CalendarEvent
    for (var element in dataCalender) {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(element.date);
      if (element.type!.isNotEmpty && element.title!.isEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.type ?? 'NODATA ONE',
          eventDate: parsedDate,
          eventBackgroundColor: Colors.blueAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.title ?? 'NODATA TWO',
          eventDate: parsedDate,
          eventBackgroundColor: Colors.amberAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isNotEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.type ?? 'NOData',
          eventDate: parsedDate,
          eventBackgroundColor: Colors.blueAccent,
          eventTextStyle: eventTextStyle,
        ));
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.title ?? 'no DATA',
          eventDate: parsedDate,
          eventBackgroundColor: Colors.amberAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else {
        break;
      }
    }

    // Debug print to verify the contents of sampleEvents
    for (var event in sampleEvents) {
      print('Event Name: ${event.eventName}');
      print('Event Date: ${event.eventDate}');
      print('Note: ${event.note}');
    }
    update();
  }

  final cellCalendarPageController = CellCalendarPageController();
  static const eventTextStyle =
      TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w400);

  List<CalendarEvent> sampleEvents = [];

  void checkValueDate() {
    sampleEvents.forEach((element) {
      print(element.eventDate);
    });
  }

  void checkEvenCalender() {
    if (typeText.isNotEmpty && titleText.isNotEmpty) {
      print("55555555555555555");
      addEvenTypeTextAndTitleText();
    } else if (titleText.isNotEmpty) {
      print("1111111111111111111");
      addEvenTitleText();
    } else if (typeText.isNotEmpty) {
      print("333333333333333");
      addEvenTypeText();
    } else {
      return;
    }
    loadDataCalender();
    update();
  }

  void addEvenTypeText() {
    for (DateTime date = testStartDate;
        date.isBefore(testEndDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: typeText, title: '', date: date.toString(), note: textNote));
      DaDtaCalender.instance.dataCalender.add(postData);
      // sampleEvents.add(CalendarEvent(
      //     note: textNote,
      //     eventName: typeText ?? 'NODATA ONE',
      //     eventDate: date,
      //     eventBackgroundColor: Colors.blueAccent,
      //     eventTextStyle: eventTextStyle));
    }
    update();
  }

  void addEvenTitleText() {
    for (DateTime date = testStartDate;
        date.isBefore(testEndDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: '', title: titleText, date: date.toString(), note: textNote));
      DaDtaCalender.instance.dataCalender.add(postData);
    }
  }

  void addEvenTypeTextAndTitleText() {
    for (DateTime date = testStartDate;
        date.isBefore(testEndDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: typeText,
          title: titleText,
          date: date.toString(),
          note: textNote));
      DaDtaCalender.instance.dataCalender.add(postData);
    }
  }

  // reset _ value
  void resetValue() {
    recordStDate = DateTime.now();
    typeText = '';
    titleText = '';
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(DateTime.now());
    final buddhistYear = DateTime.now().year + 543;
    String dataDate = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    startDateFormat.value = dataDate;
    endDateFormat.value = dataDate;
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>$typeText");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>$titleText");
  }
}
