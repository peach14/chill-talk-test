import 'dart:developer';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../base/theme/custom_text_styles.dart';
import '../service/data_calender.dart';

class CalenderViewModel extends GetxController {
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

    final startTime = TimeOfDay.now();
    int hour = startTime.hour;
    if (startTime.period == DayPeriod.pm && startTime.hour != 12) {
      hour + 12;
    } else if (startTime.period == DayPeriod.am && startTime.hour == 12) {
      hour = 0;
    }
    int minute = startTime.minute;
    String formattedTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    editStartTime = formattedTime;
    editEndTime = formattedTime;
    showStartTime.value = formattedTime;
    showEndTime.value = formattedTime;
    super.onInit();
  }

  @override
  void onClose() {
    //  recordStDate = DateTime.now();
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
  DateTime startDates = DateTime.now();
  final startDateFormat = ''.obs;
  final validDate = 0.obs;

//  DateTime recordStDate = DateTime.now();
  void setStartDate({required DateTime date}) {
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(date);
    final buddhistYear = date.year + 543;
    String dataDate = formattedDate.replaceFirst(
        date.year.toString(), buddhistYear.toString());
    startDateFormat.value = dataDate;
    // recordStDate = date;
    startDates = date;
    validDate.value = 2;
  }

  // set end Date
  final endDate = DateTime.now().obs;
  DateTime endDates = DateTime.now();
  final endDateFormat = ''.obs;
  void setEndDate({required DateTime date}) {
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(date);
    final buddhistYear = date.year + 543;
    String dataDate = formattedDate.replaceFirst(
        date.year.toString(), buddhistYear.toString());
    endDateFormat.value = dataDate;
    endDates = date;
  }

  // set checkBox Date
  final checkBox = false.obs;
  void setCheckBox() {
    checkBox.value = !checkBox.value;
    if (checkBox.value) {
      final dateFormat = DateFormat('EEEE d MMMM y', 'th');
      final formattedDate = dateFormat.format(DateTime.now());
      final buddhistYear = DateTime.now().year + 543;
      String dataDate = formattedDate.replaceFirst(
          DateTime.now().year.toString(), buddhistYear.toString());
      startDateFormat.value = dataDate;
      startDates = DateTime.now();
      endDateFormat.value = dataDate;
      // endDates = DateTime.now();
      validDate.value = 2;
      // editStartTime.value = '';
      // editEndTime.value = '';
    } else {
      validDate.value = 0;
    }
  }

  final showStartTime = ''.obs;
  String editStartTime = '';
  final selectStartTime = TimeOfDay.now().obs;
  void setStartTime({required TimeOfDay time}) {
    // Convert to 24-hour format
    int hour = time.hour;
    if (time.period == DayPeriod.pm && time.hour != 12) {
      hour + 12;
    } else if (time.period == DayPeriod.am && time.hour == 12) {
      hour = 0;
    }
    int minute = time.minute;
    String formattedTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    editStartTime = formattedTime;
    showStartTime.value = formattedTime;
    print(editStartTime);
  }

  String editEndTime = '';
  final showEndTime = ''.obs;
  final selectEndTime = TimeOfDay.now().obs;
  String validEndTime = '';
  void setEndTime({required TimeOfDay date}) {
    String formattedTime =
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    editEndTime = formattedTime;
    showEndTime.value = formattedTime;
  }

  //set Type Text
  String typeText = '';
  void setTypeText({required String date}) {
    typeText = date;
    if (typeText.isNotEmpty) {
      validTypeTitle.value = true;
    } else {
      validTypeTitle.value = false;
    }
  }

  //set title Text
  String titleText = '';
  void setTitleText({required String date}) {
    titleText = date;
    if (titleText.isNotEmpty) {
      validTypeTitle.value = true;
    } else {
      if (typeText.isNotEmpty) {
      } else {
        validTypeTitle.value = false;
      }
    }
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
          note: element.note,
          firstTime: element.firstTime,
          lastTime: element.lastTime,
          lastDate: element.lastDate,
          eventName: element.type ?? 'NODATA ONE',
          eventDate: parsedDate,
          eventBackgroundColor: CustomColors.onBackground3Color,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: element.note,
          firstTime: element.firstTime,
          lastTime: element.lastTime,
          lastDate: element.lastDate,
          eventName: element.title ?? 'NODATA TWO',
          eventDate: parsedDate,
          eventBackgroundColor: CustomColors.onBackground2Color,
          eventTextStyle: eventTextStyle,
        ));
      } else if (element.type!.isNotEmpty && element.title!.isNotEmpty) {
        sampleEvents.add(CalendarEvent(
          note: element.note,
          firstTime: element.firstTime,
          lastTime: element.lastTime,
          lastDate: element.lastDate,
          eventName: element.type ?? 'NOData',
          eventDate: parsedDate,
          eventBackgroundColor: CustomColors.onBackground3Color,
          eventTextStyle: eventTextStyle,
        ));
        sampleEvents.add(CalendarEvent(
          note: element.note,
          firstTime: element.firstTime,
          lastTime: element.lastTime,
          lastDate: element.lastDate,
          eventName: element.title ?? 'no DATA',
          eventDate: parsedDate,
          eventBackgroundColor: CustomColors.onBackground2Color,
          eventTextStyle: eventTextStyle,
        ));
      } else {
        break;
      }
    }

    update();
  }

  final cellCalendarPageController = CellCalendarPageController();
  static const eventTextStyle = CustomTextStyles.body6;

  List<CalendarEvent> sampleEvents = [];

  final validTypeTitle = true.obs;
  void checkEvenCalender({required BuildContext context}) {
    if (checkBox.value == true) {
      editEndTime = '';
      editStartTime = '';
      // endDates = DateTime.now().add(Duration(days: -1));
    }
    if (typeText.isEmpty && titleText.isEmpty) {
      validTypeTitle.value = false;
      print("6666666666666><><><<<<<<<<<<<<<<<<<>>>>>>");
      if (validDate.value == 0) {
        validDate.value = 1;
        print("9999999999999><><><<<<<<<<<<<<<<<<<>>>>>>");
      }
    } else if (validDate.value == 0) {
      print("7777777777777><><><<<<<<<<<<<<<<<<<>>>>>>");
      validDate.value = 1;
    } else if (typeText.isNotEmpty && titleText.isNotEmpty) {
      validTypeTitle.value = true;

      log("55555555555555555");
      addEvenTypeTextAndTitleText();
      context.pop();
    } else if (titleText.isNotEmpty) {
      validTypeTitle.value = true;

      log("1111111111111111111");
      addEvenTitleText();
      context.pop();
    } else if (typeText.isNotEmpty) {
      validTypeTitle.value = true;

      log("333333333333333");
      addEvenTypeText();
      context.pop();
    } else {}

    loadDataCalender();
    update();
  }

  void addEvenTypeText() {
    print("kkkkkkkkkkkkkkkkkkkkkk");
    for (DateTime date = startDates;
        date.isBefore(endDates.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: typeText,
          title: '',
          date: date.toString(),
          note: textNote,
          firstTime: editStartTime,
          lastTime: editEndTime,
          lastDate: endDates.toString()));
      DaDtaCalender.instance.dataCalender.add(postData);
    }
  }

  void addEvenTitleText() {
    for (DateTime date = startDates;
        date.isBefore(endDates.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: '',
          firstTime: editStartTime,
          lastTime: editEndTime,
          title: titleText,
          date: date.toString(),
          note: textNote,
          lastDate: endDates.toString()));
      DaDtaCalender.instance.dataCalender.add(postData);
    }
  }

  void addEvenTypeTextAndTitleText() {
    for (DateTime date = startDates;
        date.isBefore(endDates.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final postData = calenderTestModelToJson(CalenderTestModel(
          type: typeText,
          firstTime: editStartTime,
          lastTime: editEndTime,
          title: titleText,
          date: date.toString(),
          note: textNote,
          lastDate: endDates.toString()));
      DaDtaCalender.instance.dataCalender.add(postData);
    }
  }

  // reset _ value
  void resetValue() {
    //  recordStDate = DateTime.now();
    typeText = '';
    titleText = '';
    final dateFormat = DateFormat('EEEE d MMMM y', 'th');
    final formattedDate = dateFormat.format(DateTime.now());
    final buddhistYear = DateTime.now().year + 543;
    String dataDate = formattedDate.replaceFirst(
        DateTime.now().year.toString(), buddhistYear.toString());
    startDateFormat.value = dataDate;
    endDateFormat.value = dataDate;
    startDates = DateTime.now();
    endDates = DateTime.now();

    final startTime = TimeOfDay.now();
    int hour = startTime.hour;
    if (startTime.period == DayPeriod.pm && startTime.hour != 12) {
      hour + 12;
    } else if (startTime.period == DayPeriod.am && startTime.hour == 12) {
      hour = 0;
    }
    int minute = startTime.minute;
    String formattedTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    editStartTime = formattedTime;
    editEndTime = formattedTime;
    showStartTime.value = formattedTime;
    showEndTime.value = formattedTime;
    validTypeTitle.value = true;
    validDate.value = 0;
    checkBox.value = false;
  }
}
