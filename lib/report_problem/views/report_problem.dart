import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../base/component/custom_dropdown.dart';
import '../../base/utils/constants/asset_phat.dart';

class ReportProBlem extends StatefulWidget {
  const ReportProBlem({super.key});

  @override
  State<ReportProBlem> createState() => _ReportProBlemState();
}

class _ReportProBlemState extends State<ReportProBlem> {
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();
  bool checkBox = false;
  // final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              // radius: ,
              borderRadius: BorderRadius.circular(50),

              // borderRadius: BorderRadius.all(Radius.zero),
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(IconPhat.backButton)),
          title: const Text("แจ้งปัญหา", style: TextStyle(fontSize: 20)),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                          textAlign: TextAlign.center,
                          "บันทึก",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff1a6cae),
                              fontWeight: FontWeight.w500)
                          //TextStyle(fontSize: 14),
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 21,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "วันที่",
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xff1a6cae),
                          fontWeight: FontWeight.bold),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: const Column(
                                        children: [
                                          Text("วันพฤหัสบดี 9 มิถุนายน 2565"),
                                        ],
                                      ))),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 8),
                                      child: const Column(
                                        children: [
                                          Text("13.00"),
                                        ],
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "แจ้งปัญหา",
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xff1a6cae),
                          fontWeight: FontWeight.bold),
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: CustomDropDown(
                            isExpanded: true,
                            item: ["asdas", "asdasd", "asd"],
                            direction: DropdownDirection.textDirection,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "รายละเอียดเพิ่มเติม",
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xff1a6cae),
                          fontWeight: FontWeight.bold),
                    ),
                    buildTextFormField(),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ));
  }

  TextFormField buildTextFormField() {
    return TextFormField(
        enabled: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top, // align text to the top
        clipBehavior: Clip.antiAlias,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8, top: 8, bottom: 99),
          filled: true,
          fillColor: Colors.white38,
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.white38)),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.green)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Color(0xff1a6cae))),
          // isDense: true,
        ));
  }
}
