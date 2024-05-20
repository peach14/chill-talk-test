import 'dart:convert';

String requestProblemModelToJson({required RequestProblemModel data}) =>
    json.encode(data.toJson());

class RequestProblemModel {
  String title;
  String typeproblem;
  String detail;
  String userCode;
  String centerCode;
  String problemid;

  RequestProblemModel({
    required this.title,
    required this.typeproblem,
    required this.detail,
    required this.userCode,
    required this.centerCode,
    required this.problemid,
  });

  factory RequestProblemModel.fromJson(Map<String, dynamic> json) =>
      RequestProblemModel(
        title: json["title"],
        typeproblem: json["typeproblem"],
        detail: json["detail"],
        userCode: json["user_code"],
        centerCode: json["center_code"],
        problemid: json["problemid"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "typeproblem": typeproblem,
        "detail": detail,
        "user_code": userCode,
        "center_code": centerCode,
        "problemid": problemid,
      };
}
