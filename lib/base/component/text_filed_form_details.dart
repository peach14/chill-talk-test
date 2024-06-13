import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class TextFiledFormDetails extends StatelessWidget {
  const TextFiledFormDetails({
    super.key,
    required this.onChanged,
  });
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        enabled: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top, // align text to the top
        clipBehavior: Clip.antiAlias,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 8, top: 8, bottom: 99),
          filled: true,
          fillColor: CustomColors.onBackground4Color,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.onBackground4Color)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.borderColor2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.primaryColor)),
          // isDense: true,
        ));
  }
}
