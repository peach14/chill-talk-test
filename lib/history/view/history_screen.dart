import 'package:flutter/material.dart';

import '../../base/utils/constants/asset_phat.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
        title: const Text("ประวัติ", style: TextStyle(fontSize: 20)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0))),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ศ. 10/6/2565",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Column(
                  children: [
                    Text(
                      "เข้า : 8.19 น.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.green),
                    ),
                    Text("ออก : 18.12 น.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.blue)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
