import 'package:flutter/material.dart';

import '../theme/custom_text_styles.dart';

class CustomIconButtonMain extends StatelessWidget {
  const CustomIconButtonMain({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
  });
  final void Function()? onTap;
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
              style: CustomTextStyles.body,
            )
          ],
        ),
      ),
    );
  }
}
