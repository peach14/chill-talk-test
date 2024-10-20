import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/view_model/login_view_model.dart';
import '../theme/custom_colors.dart';
import 'cal_responsive.dart';

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
      initialValue: textControllers?.text,
      builder: (FormFieldState<dynamic> field) {
        return Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label != null
                  ? Text(label ?? '',
                      style: TextStyle(
                          height: 1.5,
                          fontSize:
                              CalResponsive.instance.scaleWidth(context, 15),
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold))
                  : const SizedBox.shrink(),
              SizedBox(
                height: CalResponsive.instance.scaleHeight(context, 40),
                width: width,
                child: TextFormField(
                  style: TextStyle(
                      fontSize: CalResponsive.instance.scaleWidth(context, 14)),
                  focusNode: focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: onChanged ??
                      (value) {
                        log("1111111111111111111$value");
                        field.didChange(value);
                      },
                  keyboardType: textInputType,
                  controller: textControllers,
                  // style: TextStyle(fontSize: 20),
                  decoration: FormType.email == formType
                      ? inputDecorationMobile(
                          value: controller.validEmail.value,
                          context: context,
                        )
                      : inputDecorationMobile(
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
                      ? Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "กรุณากรอกข้อมูล",
                            style: TextStyle(
                                color: CustomColors.errorColor,
                                fontSize: CalResponsive.instance
                                    .scaleWidth(context, 12)),
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              FormType.password == formType
                  ? controller.validPass.value
                      ? Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "กรุณากรอกข้อมูล",
                            style: TextStyle(
                                color: CustomColors.errorColor,
                                fontSize: CalResponsive.instance
                                    .scaleWidth(context, 12)),
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              FormType.addNote == formType
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 32)
            ],
          );
        });
      },
    );
  }

  InputDecoration inputDecorationMobile({
    required bool value,
    required BuildContext context,
  }) {
    return InputDecoration(
        // enabled: true,
        filled: true,
        fillColor: backgroundColor ?? Colors.white38,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                CalResponsive.instance.scaleWidth(context, 12))),
            borderSide: const BorderSide(color: Colors.white38)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                CalResponsive.instance.scaleWidth(context, 12))),
            borderSide: BorderSide(
                width: 1.3,
                color: value || controller.resError.value.status == 0
                    ? CustomColors.errorColor
                    : broderColor ?? CustomColors.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                CalResponsive.instance.scaleWidth(context, 12))),
            borderSide:
                BorderSide(color: value ? CustomColors.errorColor : CustomColors.primaryColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(CalResponsive.instance.scaleWidth(context, 12))), borderSide: const BorderSide(color: CustomColors.primaryColor)),
        hintStyle: hintStyle,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(24, 0, 0, isPassword == true ? MediaQuery.of(context).size.height * 0.025 : MediaQuery.of(context).size.height * 0),
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
        suffixIcon: isPassword == true
            ? Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(90),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(90),
                    onTap: onPressed ??
                        () {
                          controller.setEnablePassword();
                        },
                    child: iconSubmit ??
                        Icon(
                          color: CustomColors.primaryColor,
                          controller.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: CalResponsive.instance.scaleWidth(context, 24),
                        ),
                  ),
                ),
              )
            : Container(
                color: Colors.transparent,
                constraints: BoxConstraints(
                    maxWidth: 6,
                    maxHeight:
                        MediaQuery.of(context).size.width >= 768 ? 90 : 40),
              ));
  }
}
