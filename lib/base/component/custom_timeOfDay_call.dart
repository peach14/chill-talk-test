import 'package:chill_talk_test/base/theme/custom_colors.dart';
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
              onPrimary: CustomColors.onBackgroundColor, // Header text color
              onSurface: CustomColors.text1Color, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.text1Color, // Button text color
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
