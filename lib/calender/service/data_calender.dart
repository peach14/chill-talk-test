class DaDtaCalender {
  DaDtaCalender._();
  static final instance = DaDtaCalender._();
  List<Map<String, dynamic>> dataCalender = [
    // {
    //   "type": "AAAAAAAAAA",
    //   "title": "AAAAAAAAAA",
    //   "date": "2024-05-27",
    //   "note": "adsffffsggfsffweew"
    // },
    // {
    //   "type": "BBBBBBBBBB",
    //   "title": "BBBBBBBBB",
    //   "date": "2024-05-1",
    //   "note": "adsffffsggfsffweew"
    // },
    // {
    //   "type": "CCCCCCCCCCCCCCC",
    //   "title": "CCCCCCCCCCCCCCC",
    //   "date": "2024-05-15",
    //   "note": "adsffffsggfsffweew"
    // },
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

  CalenderTestModel({
    required this.type,
    required this.title,
    required this.date,
    required this.note,
  });

  factory CalenderTestModel.fromJson(Map<String, dynamic> json) =>
      CalenderTestModel(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "note": note,
      };
}
