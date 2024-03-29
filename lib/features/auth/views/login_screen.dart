import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/asset/asset_phat.dart';
import '../component/base_scaffold_auth.dart';
import '../component/button_custom.dart';
import '../component/text_form_field_custom.dart';

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
        const Spacer(),
        SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImagePhat.logoChillTalk,
              ),
              const SizedBox(
                height: 40,
              ),
              const TextFormFieldCustom(
                label: "อีเมล",
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFormFieldCustom(
                label: "รหัสผ่าน",
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonCustom(
                borderRadius: 12,
                color: Colors.blue.shade700,
                borderColors: Colors.blue.shade800,
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
          flex: 4,
        ),
      ],
    ));
  }
}
