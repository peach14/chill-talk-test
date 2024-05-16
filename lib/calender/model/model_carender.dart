import 'dart:convert';

ModelCarender modelCarenderFromJson(Map<String, dynamic> str) =>
    ModelCarender.fromJson(str);

String modelCarenderToJson(ModelCarender data) => json.encode(data.toJson());

class ModelCarender {
  String type;
  String title;
  String date;
  String time;

  ModelCarender({
    required this.type,
    required this.title,
    required this.date,
    required this.time,
  });

  factory ModelCarender.fromJson(Map<String, dynamic> json) => ModelCarender(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "time": time,
      };
}
