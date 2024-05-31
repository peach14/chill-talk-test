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
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));
  }
}
