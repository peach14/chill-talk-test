import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/history_model.dart';
import '../service/history_service.dart';

class HistoryViewModel extends GetxController {
  Map<String, List<String>> showGroupedData = {};
  List<String> dateIsToday = [];
  int status = 0;
  // Future<List<String>>? loading({List<String>? loading}) async {
  //   return loading ?? [''];
  // }

  void loadDataHistory(BuildContext context) async {
    showGroupedData = {};
    dateIsToday = [];
    status = 0;
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult != ConnectivityResult.none) {
    // ignore: use_build_context_synchronously
    var res = await HistoryService.instance.repoHistory(context: context);
    print(res.runtimeType);
    print(res);
    if (res != 'null') {
      if (res == '[]') {
        status = 1;
      } else if (res.length > 5) {
        // final test = [
        //   {"date": "2024-03-21", "time": "07:21"},
        //   {"date": "2024-03-21", "time": "13:00"},
        //   {"date": "2024-03-21", "time": "17:02"},
        //   {"date": "2024-03-22", "time": "07:01"},
        //   {"date": "2024-03-22", "time": "17:02"},
        //   {"date": "2024-05-01", "time": "08:31"},
        //   {"date": "2024-05-01", "time": "13:01"},
        //   {"date": "2024-05-01", "time": "19:01"},
        //   {"date": "2024-05-03", "time": "12:00"},
        //   {"date": "2024-05-03", "time": "19:01"},
        //   {"date": "2024-07-20", "time": "11:59"},
        //   {"date": "2024-07-20", "time": "19:07"},
        // ];

        final resModel = historyModelFromJson(str: res);
        // Group the data by date
        final Map<String, List<String>> groupedData = {};
        for (var entry in resModel) {
          String date = entry.date.toString().split(' ')[0];
          String time = entry.time;
          if (groupedData.containsKey(date)) {
            groupedData[date]!.add(time);
          } else {
            groupedData[date] = [time];
          }
        }
        final List<String> dates = groupedData.keys.toList();
        showGroupedData = groupedData;
        dateIsToday = dates.reversed.toList();
        status = 2;
      }
      // loading(loading: dates);
    }

    update();
  }

  //else {
  // ignore: use_build_context_synchronously
  // dialogAlert(
  //   context: context,
  //   colorButton: CustomColors.primaryColor,
  //   content: const Text("ไม่พบ สัญญาณอินเตอร์เน็ตAA"),
  //   //  alertTitle: "ไม่พบ สัญญาณอินเตอร์เน็ต",
  //   onTap: () {
  //     context.pop();
  //   },
  // );
  // }
  //}
}
