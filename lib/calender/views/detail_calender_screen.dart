import 'dart:developer';

import 'package:chill_talk_test/base/theme/custom_text_styles.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              context.pop();
            },
            child: Image.asset(IconPhat.backButton)),
        title: data!.type.isEmpty
            ? Text(data.title, style: CustomTextStyles.header)
            : Text(data.type, style: CustomTextStyles.header),
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
                    style: CustomTextStyles.body8,
                  ),
                if (data.lastDate.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.date == data.lastDate
                          ? Text(
                              data.date,
                              style: CustomTextStyles.body,
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
                                  style: CustomTextStyles.body,
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
                            style: CustomTextStyles.body,
                          ),
                        if (data.lastTime.isNotEmpty)
                          const Text(
                            "ถึง",
                            style: CustomTextStyles.body9,
                          ),
                        if (data.lastTime.isNotEmpty)
                          Text(
                            data.lastTime,
                            style: CustomTextStyles.body,
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
              style: CustomTextStyles.body10,
            ),
            const SizedBox(
              height: 8,
            ),
            if (data.type.isNotEmpty && data.title.isNotEmpty)
              Text("หัวข้อ  ${data.title}", style: CustomTextStyles.body11),
            Text(data.note, style: CustomTextStyles.body12)
          ],
        ),
      ),
    );
  }
}
