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
    final getDataJson = DaDtaCalender.instance.dataCalender;
    String dataJson = getDataJson.toString();
    print(dataJson);
    final dataCalender = calenderTestModelFromJson(getDataJson);

    dataCalender.forEach((element) {
      DateTime parsedDate =
          DateFormat("yyyy-MM-dd").parse(element.date as String);

      if (element.type!.isNotEmpty && element.title!.isEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.type ?? '',
          eventDate: parsedDate,
          // add(const Duration(days: -42)),
          eventBackgroundColor: Colors.blueAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.title ?? '',
          eventDate: parsedDate,
          // add(const Duration(days: -42)),
          eventBackgroundColor: Colors.amberAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isNotEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.type ?? '',
          eventDate: parsedDate,
          // add(const Duration(days: -42)),
          eventBackgroundColor: Colors.blueAccent,
          eventTextStyle: eventTextStyle,
        ));
        sampleEvents.add(CalendarEvent(
          note: textNote,
          eventName: element.title ?? '',
          eventDate: parsedDate,
          // add(const Duration(days: -42)),
          eventBackgroundColor: Colors.amberAccent,
          eventTextStyle: eventTextStyle,
        ));
      } else {
        return;
      }
    });

    // asd[0]['']
    CalendarEvent(
      eventName: "Writing test",
      eventDate: _today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    );
    update();
  }

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

  void checkValueDate() {
    sampleEvents.forEach((element) {
      print(element.eventDate);
    });
  }

  void setDateTest() {
    for (DateTime date = testStartDate;
        date.isBefore(testEndDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      if (typeText.isNotEmpty && titleText.isEmpty) {
        final postData = calenderTestModelToJson(CalenderTestModel(
            type: typeText, title: '', date: date.toString(), note: textNote));
        DaDtaCalender.instance.dataCalender.add(postData);
      } else if (typeText.isEmpty && titleText.isNotEmpty) {
        final postData = calenderTestModelToJson(CalenderTestModel(
            type: '', title: titleText, date: date.toString(), note: textNote));
        DaDtaCalender.instance.dataCalender.add(postData);
      } else if (typeText.isNotEmpty && titleText.isNotEmpty) {
        final postData = calenderTestModelToJson(CalenderTestModel(
            type: typeText,
            title: titleText,
            date: date.toString(),
            note: textNote));
        DaDtaCalender.instance.dataCalender.add(postData);
      } else {
        return;
      }
    }

    // // Print the sampleEvents to verify
    // for (var event in sampleEvents) {
    //   print('Event: ${event.eventName}, Date: ${event.eventDate}');
    // }
//    loadDataCalender();
    update();
  }

// Add Date
  void addEvenDate() {
    if (typeText.isNotEmpty && titleText.isEmpty) {
      sampleEvents.add(CalendarEvent(
        note: textNote,
        eventName: typeText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.blueAccent,
        eventTextStyle: eventTextStyle,
      ));
    } else if (typeText.isEmpty && titleText.isNotEmpty) {
      sampleEvents.add(CalendarEvent(
        note: textNote,
        eventName: titleText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.amberAccent,
        eventTextStyle: eventTextStyle,
      ));
    } else if (typeText.isNotEmpty && titleText.isNotEmpty) {
      sampleEvents.add(CalendarEvent(
        note: textNote,
        eventName: typeText,
        eventDate: recordStDate,
        // add(const Duration(days: -42)),
        eventBackgroundColor: Colors.blueAccent,
        eventTextStyle: eventTextStyle,
      ));
      sampleEvents.add(CalendarEvent(
        note: textNote,
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
  }
}
