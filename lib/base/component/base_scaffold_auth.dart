import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

import '../utils/constants/asset_phat.dart';
import 'cal_responsive.dart';

class BaseScaffoldAuth extends StatelessWidget {
  const BaseScaffoldAuth({
    super.key,
    required this.body,
  });
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.onBackgroundColor,
          image: DecorationImage(
              alignment: Alignment.bottomRight,
              image: AssetImage(
                IconPhat.group,
              ))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: CalResponsive.instance.scaleWidth(context, 32)),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
