import 'dart:convert';

ModelCarender modelCarenderFromJson(Map<String, dynamic> str) =>
    ModelCarender.fromJson(str);

String modelCarenderToJson(ModelCarender data) => json.encode(data.toJson());

class ModelCarender {
  String type;
  String title;
  String date;
  String lastDate;
  String firstTime;
  String lastTime;
  String time;
  String note;

  ModelCarender({
    required this.type,
    required this.title,
    required this.date,
    required this.lastDate,
    required this.firstTime,
    required this.lastTime,
    required this.time,
    required this.note,
  });

  factory ModelCarender.fromJson(Map<String, dynamic> json) => ModelCarender(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        lastDate: json["lastDate"],
        time: json["time"],
        note: json["note"],
        firstTime: json["firstTime"],
        lastTime: json["lastTime"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "time": time,
        "note": note,
        "lastDate": lastDate,
        "firstTime": firstTime,
        "lastTime": lastTime,
      };
}
