class DaDtaCalender {
  DaDtaCalender._();
  static final instance = DaDtaCalender._();
  List<Map<String, dynamic>> dataCalender = [
    {
      "type": "AAAAAAAAAA",
      "title": "AAAAAAAAAA",
      "date": "2024-05-27",
      "note": "adsffffsggfsffweew",
      "lastDate": "",
      "firstTime": "08.30",
      "lastTime": "14.00",
    },
    {
      "type": "BBBBBBBBBB",
      "title": "BBBBBBBBB",
      "date": "2024-05-1",
      "note": "adsffffsggfsffweew",
      "lastDate": "2024-05-3",
      "firstTime": "08.30",
      "lastTime": "14.00",
    },
    {
      "type": "BBBBBBBBBB",
      "title": "BBBBBBBBB",
      "date": "2024-05-2",
      "note": "adsffffsggfsffweew",
      "lastDate": "2024-05-3",
      "firstTime": "08.30",
      "lastTime": "14.00",
    },
    {
      "type": "BBBBBBBBBB",
      "title": "BBBBBBBBB",
      "date": "2024-05-3",
      "note": "adsffffsggfsffweew",
      "lastDate": "2024-05-3",
      "firstTime": "09.00",
      "lastTime": "16.00",
    },
    {
      "type": "CCCCCCCCCCCCCCC",
      "title": "GGGGGGGGGGGGGGGGGGGG",
      "date": "2024-05-15",
      "note":
          "adsffffsggfsffweewadsffffsggfsffweewadsffffsggfsffweewadsffffsggfsffweewadsffffsggfsffweewadsffffsggfsffweew",
      "lastDate": "",
      "firstTime": "",
      "lastTime": "",
    },
  ];
}

// List<CalenderTestModel> calenderTestModelFromJson(String str) =>
//     List<CalenderTestModel>.from(
//         json.decode(str).map((x) => CalenderTestModel.fromJson(x)));
List<CalenderTestModel> calenderTestModelFromJson(
        List<Map<String, dynamic>> str) =>
    List<CalenderTestModel>.from(str.map((x) => CalenderTestModel.fromJson(x)));

Map<String, dynamic> calenderTestModelToJson(CalenderTestModel data) =>
    data.toJson();

class CalenderTestModel {
  String? type;
  String? title;
  String date;
  String note;
  String? lastDate;
  String? firstTime;
  String? lastTime;

  CalenderTestModel({
    required this.type,
    required this.title,
    required this.date,
    required this.note,
    required this.lastDate,
    this.firstTime,
    this.lastTime,
  });

  factory CalenderTestModel.fromJson(Map<String, dynamic> json) =>
      CalenderTestModel(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        note: json["note"],
        lastDate: json["lastDate"],
        firstTime: json["firstTime"],
        lastTime: json["lastTime"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "note": note,
        "lastDate": lastDate,
        "firstTime": firstTime,
        "lastTime": lastTime
      };
}
