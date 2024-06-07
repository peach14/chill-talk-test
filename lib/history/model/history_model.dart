import 'dart:convert';

List<HistoryModel> historyModelFromJson({required String str}) =>
    List<HistoryModel>.from(
        json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  String id;
  String jobCode;
  String userCode;
  String period;
  DateTime date;
  String time;
  DateTime createdate;
  String imagepath;
  String status;

  HistoryModel({
    required this.id,
    required this.jobCode,
    required this.userCode,
    required this.period,
    required this.date,
    required this.time,
    required this.createdate,
    required this.imagepath,
    required this.status,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        jobCode: json["job_code"],
        userCode: json["user_code"],
        period: json["period"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        createdate: DateTime.parse(json["createdate"]),
        imagepath: json["imagepath"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_code": jobCode,
        "user_code": userCode,
        "period": period,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "createdate": createdate.toIso8601String(),
        "imagepath": imagepath,
        "status": status,
      };
}
