import 'package:flutter/material.dart';

import '../../../constants/asset/asset_phat.dart';

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
          color: Colors.white,
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
                  const Spacer(),
                  Expanded(
                      flex: 15,
                      child: Container(
                        child: body,
                      )),
                  const Spacer()
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
