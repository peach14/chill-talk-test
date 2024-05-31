import 'package:flutter/material.dart';

class BaseScaffoldMain extends StatelessWidget {
  const BaseScaffoldMain({
    super.key,
    required this.bodyTop,
    required this.bodyCenter,
    required this.bodyBottom,
  });
  final Widget bodyTop;
  final Widget bodyCenter;
  final Widget bodyBottom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Column(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff1568ac), Color(0xffffffff)],
                begin: Alignment(0.00, -0.4),
                end: Alignment(0, 2),
              )

                  // LinearGradient(
                  //   begin: const Alignment(0.00, -1.00),
                  //   end: const Alignment(0, 1),
                  //   colors: [
                  //     Colors.blue.shade800,
                  //     Colors.blue.shade700,
                  //     Colors.blue.shade400,
                  //     Colors.blue.shade100,
                  //   ],
                  // ),
                  ),
              child: bodyTop,
            )),
            Expanded(
                child: Row(
              children: [
                const Spacer(),
                bodyBottom,
                //  const Spacer(flex: 14),
              ],
            ))
          ],
        ),
        bodyCenter
      ]),
    );
  }
}
