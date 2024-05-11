import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../base/component/base_scaffold_auth.dart';
import '../../../base/component/button_custom.dart';
import '../../../base/component/text_form_field_custom.dart';
import '../../base/utils/constants/asset_phat.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAuth(
        body: Column(
      children: [
        // SizedBox(
        //   height: 34,
        // ),
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
              const TextFormFieldCustom(
                label: "อีเมล",
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              const TextFormFieldCustom(
                label: "รหัสผ่าน",
              ),
              const SizedBox(
                height: 34,
              ),
              ButtonCustom(
                borderRadius: 12,
                color: Color(0xff1a6cae),
                borderColors: Color(0xff1a6cae),
                width: double.infinity,
                height: 45,
                text: 'เข้าสู่ระบบ',
                textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                onTap: () {
                  context.go('/home');
                },
              )
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
