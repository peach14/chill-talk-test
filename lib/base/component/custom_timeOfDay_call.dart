import 'package:flutter/material.dart';

class CustomTimeOfDayCall {
  CustomTimeOfDayCall._();
  static final instance = CustomTimeOfDayCall._();
  Future<TimeOfDay?> timeOfDay(
      {required Color themeColor,
      required TimeOfDay initialTime,
      required String helpText,
      required BuildContext context}) async {
    return await showTimePicker(
      hourLabelText: "ชั่วโมง",
      minuteLabelText: "นาที",
      context: context,
      initialTime: initialTime,
      barrierDismissible: false,
      helpText: helpText,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: themeColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.dial,
    );
  }
}
