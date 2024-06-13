import 'package:chill_talk_test/base/theme/custom_colors.dart';
import 'package:flutter/material.dart';

import '../utils/constants/asset_phat.dart';

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
              image: AssetImage(IconPhat.group))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  // SizedBox(
                  //   width: 32,
                  // ),
                  Expanded(
                      flex: 15,
                      child: Container(
                        child: body,
                      )),
                  // SizedBox(
                  //   width: 32,
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
