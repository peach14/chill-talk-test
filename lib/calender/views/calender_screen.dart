import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../base/component/dialog_alert.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../main/view_model/bindings/app_binding.dart';
import '../model/model_carender.dart';
import '../view_model/calender_view_model.dart';

class CalenderScreen extends GetView<AppViewModel> {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<AppBinding>(AppBinding());
    final events = controller.sampleEvents;
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              // radius: ,
              borderRadius: BorderRadius.circular(50),

              // borderRadius: BorderRadius.all(Radius.zero),
              onTap: () {
                // context.pushReplacement(kNevMain);
                context.pop();
              },
              child: Image.asset(IconPhat.backButton)),
          title: const Text("มิถุนายยน 2565", style: TextStyle(fontSize: 20)),
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(25.0),
              child: Container(
                //  color: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 5),
                // height: 15,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("อา.", style: TextStyle(color: Colors.white)),
                    Text("จ.", style: TextStyle(color: Colors.white)),
                    Text("อ.", style: TextStyle(color: Colors.white)),
                    Text("พ.", style: TextStyle(color: Colors.white)),
                    Text("พฤ.", style: TextStyle(color: Colors.white)),
                    Text("ศ.", style: TextStyle(color: Colors.white)),
                    Text("ส.", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ))),
      body: GetBuilder<AppViewModel>(
        init: AppViewModel(),
        builder: (AppViewModel controllerss) {
          // controller.sampleEvents.value.forEach((element) {
          //   print(element.eventName);
          // });
          //   final clr = Get.find<AppViewModel>();
          return CellCalendar(
            cellCalendarPageController: controllerss.cellCalendarPageController,
            events: controllerss.sampleEvents,
            daysOfTheWeekBuilder: (dayIndex) {
              return const SizedBox.shrink();
            },
            monthYearLabelBuilder: (datetime) {
              final year = datetime!.year.toString();
              final month = datetime.month.monthName;
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                  ],
                ),
              );
            },
            onCellTapped: (date) {
              final eventsOnTheDate = events.where((event) {
                final eventDate = event.eventDate;
                return eventDate.year == date.year &&
                    eventDate.month == date.month &&
                    eventDate.day == date.day;
              }).toList();

              try {
                String type = eventsOnTheDate.first.eventName;
                String title = eventsOnTheDate.last.eventName;

                String dataDate =
                    DateFormat('EEEE d MMMM y', 'th').format(DateTime(
                  eventsOnTheDate.first.eventDate.year + 543,
                  eventsOnTheDate.first.eventDate.month,
                  eventsOnTheDate.first.eventDate.day,
                ));

                context.push('/detail',
                    extra: ModelCarender(
                        type: type, title: title, date: dataDate, time: ''));
              } catch (e) {
                // print(object)
                // String dataDate =
                // DateFormat('EEEE d MMMM y', 'th').format(DateTime(
                //   eventsOnTheDate.first.eventDate.year + 543,
                //   eventsOnTheDate.first.eventDate.month,
                //   eventsOnTheDate.first.eventDate.day,
                // ));
                // print(dataDate);

                dialogAlert(
                  context: context,
                  content: const Text("ไม่มีนัดหมาย"),
                  titleIcon: Text("Data"),
                  onTap: () {
                    Navigator.pop(context);
                    // Reset isDialogShown when dialog is dismissed
                  },
                );
                print("555555555555555555555");
              }
            },
            onPageChanged: (firstDate, lastDate) {},
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            // final DateTime? datetime = await showDatePicker(
            //     confirmText: "ตกลง",
            //     cancelText: 'ยกเลิก',
            //     context: context,
            //     helpText: 'วันที่เริ่มลา',
            //     locale: const Locale('th'),
            //     initialDate: selectDate,
            //     builder: (context, child) {
            //       return Theme(
            //         data: ThemeData.light().copyWith(
            //           colorScheme: const ColorScheme.light(
            //             onBackground: Colors.blue,
            //             primary: Colors.blue, // Header background color
            //             onPrimary: Colors.white, // Header text color
            //             onSurface: Colors.black, // Body text color
            //           ),
            //           textButtonTheme: TextButtonThemeData(
            //             style: TextButton.styleFrom(
            //               foregroundColor: Colors.black, // Button text color
            //             ),
            //           ),
            //         ),
            //         child: child!,
            //       );
            //     },
            //     firstDate: DateTime(2000),
            //     lastDate: DateTime(3000));
            //
            // if (datetime != null) {
            //   setState(() {
            //     selectDate = datetime;
            //     //     EventsDate.instan.addEvenDate(date: selectDate);
            //
            //     // sampleEvents(head: "asdasd", startDate: selectDate);
            //   });
            // }
            controller.setDispod();
            context.push("/addNote");
          }),
    );
  }
}
