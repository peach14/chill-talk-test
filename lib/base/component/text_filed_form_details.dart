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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8, top: 8, bottom: 99),
          filled: true,
          fillColor: Colors.white38,
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.white38)),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.green)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Color(0xff1a6cae))),
          // isDense: true,
        ));
  }
}
