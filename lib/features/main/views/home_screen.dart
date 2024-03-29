import 'package:chill_talk_test/constants/asset/asset_phat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/base_scaffold_main.dart';
import '../component/custom_bottom_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldMain(
      bodyTop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Spacer(
                flex: 4,
              ),
              const Text("หน้าแรก",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const Spacer(
                flex: 3,
              ),
              const Text(
                "8:55 AM",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("วันจันทร์ที่ 12 ตุลาคม 2564",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              const Text("กมลพร ชัยเลิศจิต",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(IconPhat.nearMe),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("Chilltalk Co.th",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const Spacer(
                flex: 6,
              ),
            ],
          ),
        ],
      ),
      bodyCenter: Row(
        children: [
          const Spacer(),
          CustomBottomHome(
            icon: IconPhat.out1Icon,
            text: 'บันทึก\nเข้างาน',
            onTap: () {},
          ),
          const Spacer(),
          CustomBottomHome(
            icon: IconPhat.out2Icon,
            color: Colors.white,
            textColor: Colors.blue.shade700,
            text: 'บันทึก\nออกงาน',
            onTap: () {
              context.go('/');
            },
          ),
          const Spacer(),
        ],
      ),
      bodyBottom: Expanded(
        flex: 7,
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                Image.asset(IconPhat.calendarToday),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "ปฎิทิน",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(IconPhat.frame_32),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "แจ้งลา",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(IconPhat.frame_32_2),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "ประวัติ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(IconPhat.nextWeek),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "แจ้งปัญหา",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                )
              ],
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
