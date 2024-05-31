import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../base/utils/constants/asset_phat.dart';
import '../model/model_carender.dart';

class DetailCalenderScreen extends StatefulWidget {
  const DetailCalenderScreen({
    super.key,
  });

  @override
  State<DetailCalenderScreen> createState() => _DetailCalenderScreenState();
}

class _DetailCalenderScreenState extends State<DetailCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    Object? extra = GoRouterState.of(context).extra;

    ModelCarender? data;

    if (extra is ModelCarender) {
      data = extra;
    } else {
      log("Nodata 'Extra' in datail_calender_screen");
    }
    print(">>>>>>>>>>>type>>>>>>>>>>>>${data?.type.runtimeType}");
    print(">>>>>>>>>>>title>>>>>>>>>>>>${data?.title}");
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              context.pop();
            },
            child: Image.asset(IconPhat.backButton)),
        title: data!.type.isEmpty
            ? Text(data.title, style: const TextStyle(fontSize: 20))
            : Text(data.type, style: const TextStyle(fontSize: 20)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (data.lastDate.isEmpty)
                  Text(
                    data.date,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                if (data.lastDate.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.date == data.lastDate
                          ? Text(
                              data.date,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            )
                          : Text(
                              "${data.date} -",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                      data.date == data.lastDate
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  data.lastDate,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        if (data.firstTime.isNotEmpty)
                          Text(
                            data.firstTime,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        if (data.lastTime.isNotEmpty)
                          const Text(
                            "ถึง",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        if (data.lastTime.isNotEmpty)
                          Text(
                            data.lastTime,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "นัดหมาย",
              style: TextStyle(
                  color: Color(0xff1a6cae),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            if (data.type.isNotEmpty && data.title.isNotEmpty)
              Text("หัวข้อ  ${data.title}",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            Text(data.note,
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
