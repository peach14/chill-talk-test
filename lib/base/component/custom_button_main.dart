import 'package:flutter/material.dart';

class CustomIconButtonMain extends StatelessWidget {
  const CustomIconButtonMain({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });
  final void Function() onTap;
  final String text;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Image.asset(icon),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
