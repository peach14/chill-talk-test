import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomDateTimeCall {
  CustomDateTimeCall._();
  static final instance = CustomDateTimeCall._();

  Future<DateTime?> dateTime(
      {required BuildContext context,
      required DateTime initialDate,
      required String helpText,
      required Color onBackground,
      required Color primary}) async {
    return await showDatePicker(
        confirmText: "ตกลง",
        cancelText: 'ยกเลิก',
        context: context,
        helpText: helpText,
        locale: const Locale('th'),
        initialDate: initialDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                onBackground: onBackground,
                primary: primary, // Header background color
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
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));
  }
}
