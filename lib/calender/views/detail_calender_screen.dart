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
      print(data.type);
    } else {
      print('Extra is not of type ModelCarender');
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              context.pop();
            },
            child: Image.asset(IconPhat.backButton)),
        title: Text(data?.type ?? "", style: const TextStyle(fontSize: 20)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data?.date ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Text(
                  "10:00",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
            Text(data?.note ?? '',
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
