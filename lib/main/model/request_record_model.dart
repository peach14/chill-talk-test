import 'dart:convert';

RespModelRecordWork requestRecordModelFromJson(String str) =>
    RespModelRecordWork.fromJson(json.decode(str));

String respModelRecordWorkToJson({required RespModelRecordWork data}) =>
    json.encode(data.toJson());

class RespModelRecordWork {
  String centerCode;
  String userCode;
  String latitude;
  String longitude;

  RespModelRecordWork({
    required this.centerCode,
    required this.userCode,
    required this.latitude,
    required this.longitude,
  });

  factory RespModelRecordWork.fromJson(Map<String, dynamic> json) =>
      RespModelRecordWork(
        centerCode: json["center_code"],
        userCode: json["user_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "center_code": centerCode,
        "user_code": userCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
