import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

class CustomIconButtonMain extends StatelessWidget {
  const CustomIconButtonMain({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
    required this.iconSize,
    required this.fontSize,
  });
  final void Function()? onTap;
  final String text;
  final String icon;
  final double iconSize;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    double resize({required double referenceFontSize}) {
      double referenceWidth = 360; // Reference screen width in pixels
      double screenWidth = MediaQuery.of(context).size.width;
      double scalingFactor = referenceFontSize / referenceWidth;
      double dynamicFontSize = screenWidth * scalingFactor;
      return dynamicFontSize;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Image.asset(icon,
                width: resize(referenceFontSize: iconSize),
                height: resize(referenceFontSize: iconSize)),
            const SizedBox(
              width: 15,
            ),
            Text(text,
                style: TextStyle(
                    fontSize: resize(referenceFontSize: fontSize),
                    fontWeight: FontWeight.w600,
                    color: CustomColors.text6Color)
                //CustomTextStyles.body,
                )
          ],
        ),
      ),
    );
  }
}
