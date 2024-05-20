import 'dart:convert';

ErrorModelRecord errorModelRecordFromJson(String str) =>
    ErrorModelRecord.fromJson(json.decode(str));

String errorModelRecordToJson(ErrorModelRecord data) =>
    json.encode(data.toJson());

class ErrorModelRecord {
  int status;
  String message;

  ErrorModelRecord({
    required this.status,
    required this.message,
  });

  factory ErrorModelRecord.fromJson(Map<String, dynamic> json) =>
      ErrorModelRecord(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
