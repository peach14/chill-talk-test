import 'dart:convert';

ModelCarender modelCarenderFromJson(Map<String, dynamic> str) =>
    ModelCarender.fromJson(str);

String modelCarenderToJson(ModelCarender data) => json.encode(data.toJson());

class ModelCarender {
  String type;
  String title;
  String date;
  String time;
  String note;

  ModelCarender({
    required this.type,
    required this.title,
    required this.date,
    required this.time,
    required this.note,
  });

  factory ModelCarender.fromJson(Map<String, dynamic> json) => ModelCarender(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        time: json["time"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "time": time,
        "note": note,
      };
}
