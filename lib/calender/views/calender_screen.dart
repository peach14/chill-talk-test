import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../base/component/dialog_alert.dart';
import '../../base/config/routing/route_path.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../main/view_model/bindings/app_binding.dart';
import '../model/model_carender.dart';
import '../view_model/calender_view_model.dart';

class CalenderScreen extends GetView<CalenderViewModel> {
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
              context.pushReplacement(kNevMain);
            },
            child: Image.asset(IconPhat.backButton)),
        title: Obx(() => Text(controller.dateAppbar.value,
            style: const TextStyle(fontSize: 20))),
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
            )),
        actions: [
          IconButton(
              onPressed: () {
                controller.loadDataCalender();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: GetBuilder<CalenderViewModel>(
        init: CalenderViewModel(),
        builder: (CalenderViewModel controllerss) {
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
              datetime!.year.toString();
              datetime.month.monthName;

              Future.microtask(() {
                controllerss.setDateAppBar(date: datetime);
              });

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
                String? note = eventsOnTheDate.last.note;

                final dateFormat = DateFormat('EEEE d MMMM y', 'th');
                final formattedDate =
                    dateFormat.format(eventsOnTheDate.first.eventDate);
                final buddhistYear = DateTime.now().year + 543;
                String dataDate = formattedDate.replaceFirst(
                    DateTime.now().year.toString(), buddhistYear.toString());

                context.push('/detail',
                    extra: ModelCarender(
                        type: type,
                        title: title,
                        date: dataDate,
                        time: '',
                        note: note ?? ''));
              } catch (e) {
                // print(object)
                // String dataDate =
                // DateFormat('EEEE d MMMM y', 'th').format(DateTime(
                //   eventsOnTheDate.first.eventDate.year + 543,
                //   eventsOnTheDate.first.eventDate.month,
                //   eventsOnTheDate.first.eventDate.day,
                // ));
                // print(dataDate);
                final dateFormat = DateFormat('EEEE d MMMM y', 'th');
                final formattedDate = dateFormat.format(date);
                final buddhistYear = date.year + 543;
                String dataDate = formattedDate.replaceFirst(
                    date.year.toString(), buddhistYear.toString());

                dialogAlert(
                  context: context,
                  colorButton: Colors.red,
                  content: const Text("ไม่มีนัดหมาย"),
                  titleIcon: Text(dataDate),
                  onTap: () {
                    context.pop();
                  },
                );
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
            controller.resetValue();
            context.push("/addNote");
          }),
    );
  }
}
