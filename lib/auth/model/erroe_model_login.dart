import 'dart:convert';

ErrorModelLogin errorModelLoginFromJson(String str) =>
    ErrorModelLogin.fromJson(json.decode(str));

String errorModelLoginToJson(ErrorModelLogin data) =>
    json.encode(data.toJson());

class ErrorModelLogin {
  int status;
  String message;

  ErrorModelLogin({
    required this.status,
    required this.message,
  });

  factory ErrorModelLogin.fromJson(Map<String, dynamic> json) =>
      ErrorModelLogin(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
