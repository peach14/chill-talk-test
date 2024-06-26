import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../base/component/custom_dropdown.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/theme/custom_colors.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../view_model/problem_view_model.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();
  bool checkBox = false;
  // final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProblemViewModel());
    return GetBuilder(
      builder: (ProblemViewModel controller) {
        return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    context.pushReplacement(kNevMain);
                  },
                  child: Image.asset(IconPhat.backButton)),
              title: const Text("แจ้งปัญหา", style: TextStyle(fontSize: 20)),
              actions: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        controller.problemSend(context: context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                              textAlign: TextAlign.center,
                              "บันทึก",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: CustomColors.primaryColor,
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
                              color: CustomColors.primaryColor,
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
                                              Text(
                                                  "วันพฤหัสบดี 9 มิถุนายน 2565"),
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
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomDropDown(
                                isExpanded: true,
                                item: [
                                  "ปัญหาในระบบ",
                                  "ปัญหาในสำนักงาน",
                                  "ปัญหาบุคลากร"
                                ],
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
                              color: CustomColors.primaryColor,
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
      },
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
        enabled: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top, // align text to the top
        clipBehavior: Clip.antiAlias,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 8, top: 8, bottom: 99),
          filled: true,
          fillColor: CustomColors.borderColor1,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.borderColor2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: CustomColors.primaryColor)),
          // isDense: true,
        ));
  }
}
