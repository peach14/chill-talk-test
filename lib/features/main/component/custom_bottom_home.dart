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
  });
  final String icon;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
        side: BorderSide(
            width: 1.2,
            color: Colors.blue.shade700), // Define the border properties here
      ),
      color: color ?? Colors.blue.shade700,
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(icon)
            ],
          ),
        ),
      ),
    );
  }
}
