import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

import '../theme/custom_text_styles.dart';

Future<dynamic> dialogAlert({
  required BuildContext context,
  required Widget content,
  String? alertTitle,
  Widget? titleIcon,
  String? textButton,
  double? buttonWidth,
  Color? colorButton,
  Function()? onTap,
  bool? barrierDismissible,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        actionsPadding: const EdgeInsets.all(25),
        insetPadding: const EdgeInsets.all(35),
        titlePadding: const EdgeInsets.only(
          top: 25,
          right: 25,
          left: 25,
          bottom: 10,
        ),
        title: Column(
          children: [
            if (titleIcon != null) ...{
              titleIcon,
              const SizedBox(
                height: 5,
              )
            },
            if (alertTitle != null) ...{
              Text(
                alertTitle,
                textAlign: TextAlign.center,
                style: CustomTextStyles.body9,
              ),
            }
          ],
        ),
        content: Container(
          width: 50,
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [content],
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              color: colorButton ?? CustomColors.text4Color,
              borderRadius: BorderRadius.circular(32),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: onTap,
                child: Container(
                  height: 48,
                  width: buttonWidth,
                  alignment: Alignment.center,
                  child: const Text(
                    "ปิด",
                    style: CustomTextStyles.body3,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
