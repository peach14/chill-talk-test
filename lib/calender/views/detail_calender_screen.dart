import 'package:flutter/material.dart';

import '../../base/utils/constants/asset_phat.dart';

class DetailCalenderScreen extends StatefulWidget {
  const DetailCalenderScreen({super.key, required this.note});

  final String note;
  @override
  State<DetailCalenderScreen> createState() => _DetailCalenderScreenState();
}

class _DetailCalenderScreenState extends State<DetailCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(IconPhat.backButton)),
        title: Text(widget.note, style: const TextStyle(fontSize: 20)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ศุกร์, 10 มิถุนายน 2565",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  "10:00",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "นัดหมาย",
              style: TextStyle(
                  color: Color(0xff1a6cae),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("Weekly meeting Chill",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
