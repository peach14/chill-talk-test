import 'package:chill_talk_test/base/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/component/base_scaffold_auth.dart';
import '../../base/component/button_custom.dart';
import '../../base/component/cal_responsive.dart';
import '../../base/component/text_form_field_custom.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAuth(
        body: Column(
      children: [
        SizedBox(
          height: CalResponsive.instance.scaleHeight(context, 34),
        ),
        Image.asset(
          ImagePhat.logoChillTalk,
          width: CalResponsive.instance.scaleWidth(context, 106),
          height: CalResponsive.instance.scaleHeight(context, 169),
        ),
        SizedBox(
          height: CalResponsive.instance.scaleHeight(context, 32),
        ),
        TextFormFieldCustom(
          formType: FormType.email,
          onChanged: (value) {
            controller.setEmail(email: value!);
            return null;
          },
          label: "อีเมล",
        ),
        TextFormFieldCustom(
          formType: FormType.password,
          label: "รหัสผ่าน",
          isPassword: true,
          onChanged: (value) {
            controller.setPassword(passwords: value!);
            return null;
          },
        ),
        Obx(() {
          return controller.resError.value.status == 0
              ? Text(controller.resError.value.message,
                  style: CustomTextStyles.body4)
              : const SizedBox.shrink();
        }),
        SizedBox(
          height: CalResponsive.instance.scaleHeight(context, 34),
        ),
        ButtonCustom(
            borderRadius: CalResponsive.instance.scaleWidth(context, 12),
            color: CustomColors.primaryColor,
            borderColors: CustomColors.primaryColor,
            width: double.infinity,
            height: CalResponsive.instance.scaleHeight(context, 45),
            text: 'เข้าสู่ระบบ',
            textStyle: TextStyle(
                fontSize: CalResponsive.instance.scaleWidth(context, 14),
                color: CustomColors.onBackgroundColor,
                fontWeight: FontWeight.bold),
            onTap: () {
              controller.setValidate(context: context);
            }),
      ],
    ));
  }
}
