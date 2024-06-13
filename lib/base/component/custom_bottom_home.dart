import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomHome extends StatelessWidget {
  const CustomBottomHome({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    this.textColor,
    this.radius,
    this.onTap,
    this.borderColor,
    required this.disable,
  });
  final String icon;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? radius;
  final bool disable;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
        side: BorderSide(
            width: 1.2,
            color: borderColor ??
               CustomColors.primaryColor), // Define the border properties here
      ),
      color: color ??  CustomColors.primaryColor,
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 45),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textColor ??  CustomColors.onBackgroundColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.004,
              ),
              disable == true
                  ? Image.asset(
                      icon,
                    )
                  : Icon(
                      Icons.lock_clock_outlined,
                      color: Colors.grey.shade500,
                      size: 40,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
