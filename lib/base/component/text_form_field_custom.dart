import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/view_model/login_view_model.dart';

enum FormType { email, password, addNote }

class TextFormFieldCustom extends GetView<LoginViewModel> {
  const TextFormFieldCustom({
    super.key,
    this.textControllers,
    this.formType,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.prefixIcon,
    this.broderColor,
    this.label,
    this.isPassword,
    this.field,
    this.backgroundColor,
    this.height = 40,
    this.width = double.infinity,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.suffixIcon,
    this.enablePassword,
    this.autoValidateMode,
    this.textInputType,
    this.onPressed,
    this.iconSubmit,
  });

  final TextEditingController? textControllers;
  final String? hintText;
  final String? label;
  final String? field;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? broderColor;
  final String? prefixIcon;
  final bool? isPassword;
  final bool? enablePassword;
  // ignore: prefer_typing_uninitialized_variables
  final suffixIcon;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChanged;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? textInputType;
  final void Function()? onPressed;
  final Icon? iconSubmit;
  final FormType? formType;

  @override
  build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.always,
      validator: validator ??
          (value) {
            if (value is String) {
              return (value.isNotEmpty) ? null : "กรุณากรอกข้อมูล";
            }
            return null;
          },
      initialValue: textControllers?.text,
      builder: (FormFieldState<dynamic> field) {
        return Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label != null
                  ? Text(label ?? '',
                      style: const TextStyle(
                          height: 1.5,
                          fontSize: 15,
                          color: Color(0xff1a6cae),
                          fontWeight: FontWeight.bold))
                  : const SizedBox.shrink(),
              SizedBox(
                height: height,
                width: width,
                child: TextFormField(
                  focusNode: focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: onChanged ??
                      (value) {
                        log("1111111111111111111$value");
                        field.didChange(value);
                      },
                  keyboardType: textInputType,
                  controller: textControllers,
                  style: textStyle,
                  decoration: FormType.email == formType
                      ? inputDecoration(
                          value: controller.validEmail.value,
                          context: context,
                        )
                      : inputDecoration(
                          value: controller.validPass.value,
                          context: context,
                        ),
                  obscureText: isPassword == true
                      ? iconSubmit != null
                          ? false
                          : controller.showPassword.value
                              ? false
                              : true
                      : false,
                ),
              ),
              FormType.email == formType
                  ? controller.validEmail.value
                      ? const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "กรุณากรอกข้อมูล",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              FormType.password == formType
                  ? controller.validPass.value
                      ? const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "กรุณากรอกข้อมูล",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              FormType.addNote == formType
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 32)
            ],
          );
        });
      },
    );
  }

  InputDecoration inputDecoration({
    required bool value,
    required BuildContext context,
  }) {
    return InputDecoration(
        // enabled: true,
        filled: true,
        fillColor: backgroundColor ?? Colors.white38,
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white38)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                width: 1.3,
                color: value || controller.resError.value.status == 0
                    ? Colors.red
                    : broderColor ?? const Color(0xff1a6cae))),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: value ? Colors.red : Colors.green)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xff1a6cae))),
        hintStyle: hintStyle,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(
            24,
            0,
            0,
            isPassword == true
                ? MediaQuery.of(context).size.height * 0.025
                : MediaQuery.of(context).size.height * 0),
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Container(
                margin: const EdgeInsets.only(left: 20, right: 16),
                width: 24,
                //  height: 10,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(prefixIcon ?? ""),
                    fit: BoxFit.scaleDown,
                  ),
                  shape: const RoundedRectangleBorder(),
                ),
              )
            : null,
        // suffixIconConstraints: BoxConstraints(
        //   minWidth: 24.spMin,
        //   maxWidth: 60.spMax,
        // ),
        // prefixIconConstraints: BoxConstraints(
        //   minWidth: 24.spMin,
        //   maxWidth: 60.spMax,
        // ),
        suffixIcon: isPassword == true
            ? IconButton(
                onPressed: onPressed ??
                    () {
                      controller.setEnablePassword();
                    },
                icon: iconSubmit ??
                    Icon(
                        size: 24,
                        color: Colors.deepOrange,
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off))
            : const SizedBox());
  }
}
