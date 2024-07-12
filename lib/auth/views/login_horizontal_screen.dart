import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/component/base_scaffold_auth.dart';
import '../../base/component/button_custom.dart';
import '../../base/component/text_form_field_custom.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/theme/custom_text_styles.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/login_view_model.dart';

class LoginHorizontalScreen extends GetView<LoginViewModel> {
  const LoginHorizontalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double resize({required double referenceFontSize}) {
      double referenceWidth = 360; // Reference screen width in pixels
      double screenWidth = MediaQuery.of(context).size.width;
      double scalingFactor = referenceFontSize / referenceWidth;
      double dynamicFontSize = screenWidth * scalingFactor;
      return dynamicFontSize;
    }

    return BaseScaffoldAuth(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            ImagePhat.logoChillTalk,
            width: resize(referenceFontSize: 70),
            height: resize(referenceFontSize: 70),
          ),
          const SizedBox(
            height: 32,
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
          const SizedBox(
            height: 34,
          ),
          ButtonCustom(
              borderRadius: 12,
              color: CustomColors.primaryColor,
              borderColors: CustomColors.primaryColor,
              width: double.infinity,
              height: 45,
              text: 'เข้าสู่ระบบ',
              textStyle: CustomTextStyles.body5,
              onTap: () {
                controller.setValidate(context: context);
              })
        ],
      ),
    ));
    //     Column(
    //   children: [
    //
    //     // const Spacer(),
    //     // const Spacer(flex: 9),
    //   ],
    // ));
  }
}
