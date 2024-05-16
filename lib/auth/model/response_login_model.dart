import 'dart:convert';

ResponseModelLogin responseModelLoginFromJson(String str) =>
    ResponseModelLogin.fromJson(json.decode(str));

class ResponseModelLogin {
  String id;
  String userCode;
  String prefix;
  String name;
  String surname;
  DateTime birthdate;
  String typeUser;
  String typePosition;
  String email;
  String password;
  String mobile;
  String address;
  String centerCode;
  String userImage;
  String createdate;
  String updatedate;
  String userstatus;
  String centerName;
  String latitude;
  String longitude;
  String worktime;
  int status;
  String message;

  ResponseModelLogin({
    required this.id,
    required this.userCode,
    required this.prefix,
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.typeUser,
    required this.typePosition,
    required this.email,
    required this.password,
    required this.mobile,
    required this.address,
    required this.centerCode,
    required this.userImage,
    required this.createdate,
    required this.updatedate,
    required this.userstatus,
    required this.centerName,
    required this.latitude,
    required this.longitude,
    required this.worktime,
    required this.status,
    required this.message,
  });

  factory ResponseModelLogin.fromJson(Map<String, dynamic> json) =>
      ResponseModelLogin(
        id: json["id"],
        userCode: json["user_code"],
        prefix: json["prefix"],
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        typeUser: json["type_user"],
        typePosition: json["type_position"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        address: json["address"],
        centerCode: json["center_code"],
        userImage: json["user_image"],
        createdate: json["createdate"],
        updatedate: json["updatedate"],
        userstatus: json["userstatus"],
        centerName: json["center_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        worktime: json["worktime"],
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_code": userCode,
        "prefix": prefix,
        "name": name,
        "surname": surname,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "type_user": typeUser,
        "type_position": typePosition,
        "email": email,
        "password": password,
        "mobile": mobile,
        "address": address,
        "center_code": centerCode,
        "user_image": userImage,
        "createdate": createdate,
        "updatedate": updatedate,
        "userstatus": userstatus,
        "center_name": centerName,
        "latitude": latitude,
        "longitude": longitude,
        "worktime": worktime,
        "Status": status,
        "Message": message,
      };
}
