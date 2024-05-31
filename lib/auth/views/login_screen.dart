import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/component/base_scaffold_auth.dart';
import '../../base/component/button_custom.dart';
import '../../base/component/text_form_field_custom.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAuth(
        body: Column(
      children: [
        const Spacer(),
        SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImagePhat.logoChillTalk,
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
                onChanged: (value) {
                  controller.setPassword(passwords: value!);
                  return null;
                },
              ),
              Obx(() {
                return controller.resError.value.status == 0
                    ? Text(controller.resError.value.message,
                        style: const TextStyle(color: Colors.red))
                    : const SizedBox.shrink();
              }),
              const SizedBox(
                height: 34,
              ),
              ButtonCustom(
                  borderRadius: 12,
                  color: const Color(0xff1a6cae),
                  borderColors: const Color(0xff1a6cae),
                  width: double.infinity,
                  height: 45,
                  text: 'เข้าสู่ระบบ',
                  textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    controller.setValidate(context: context);
                  })
            ],
          ),
        ),
        const Spacer(
          flex: 9,
        ),
      ],
    ));
  }
}
