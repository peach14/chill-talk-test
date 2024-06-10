import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/history_model.dart';
import '../service/history_service.dart';

class HistoryViewModel extends GetxController {
  Map<String, List<String>> showGroupedData = {};
  List<String> dateIsToday = [];
  Future<List<String>>? loading({List<String>? loading}) async {
    return loading ?? [''];
  }

  void loadDataHistory(BuildContext context) async {
    final res = await HistoryService.instance.repoHistory(context: context);
    print(res);
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
    loading(loading: dates);

    update();
  }
}
