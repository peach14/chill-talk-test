import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropDown extends ConsumerStatefulWidget {
  const CustomDropDown(
      {required this.item,
      required this.direction,
      this.onChanged,
      this.isExpanded,
      this.hint,
      this.botTon,
      this.hintIcon,
      super.key});
  final List<String> item;
  final void Function(String? value)? onChanged;
  final bool? isExpanded;
  final String? hint;
  final Widget? botTon;
  final Widget? hintIcon;
  final DropdownDirection direction;

  @override
  ConsumerState<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends ConsumerState<CustomDropDown> {
  String? selectedValue;
  bool lineItem = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: widget.isExpanded ?? false,
        hint: Row(
          children: [
            widget.hintIcon ?? const SizedBox.shrink(),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.hint ?? '',
                style: const TextStyle(
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        customButton: widget.botTon,
        items: widget.item.asMap().entries.map((MapEntry<int, String> entry) {
          String item = entry.value;
          // String splitItem = item.split('/').last.split('.').first;
          return DropdownMenuItem<String>(
            onTap: () {
              // setState(() {
              //   lineItem = true;
              // });
            },
            value: item,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox.shrink(),
                Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // if (index == 0)
                    //   Icon(
                    //     Icons.arrow_forward_ios_outlined,
                    //     size: 14,
                    //   )
                  ],
                ),
                if (lineItem == false)
                  Divider(
                    height: 1,
                    color: Colors.grey.shade400,
                  ),
                if (lineItem == true) const SizedBox.shrink(),
              ],
            ),
          );
        }).toList(),
        barrierDismissible: true,
        value: selectedValue,
        onChanged: (value) {
          widget.onChanged?.call(value);
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          isOverButton: true,
          direction: DropdownDirection.left, // widget.direction,
          // maxHeight: 200,
          // width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
