import 'dart:convert';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestModelToJson({required RequestModel data}) =>
    json.encode(data.toJson());

class RequestModel {
  String username;
  String password;

  RequestModel({
    required this.username,
    required this.password,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
