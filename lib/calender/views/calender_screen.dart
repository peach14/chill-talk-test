import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../base/config/routing/route_path.dart';
import '../../base/utils/constants/asset_phat.dart';
import '../../main/view_model/bindings/app_binding.dart';
import '../service/data_calender.dart';
import '../view_model/calender_view_model.dart';
import '../view_model/detail_view_model.dart';

class CalenderScreen extends GetView<CalenderViewModel> {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<AppBinding>(AppBinding());
    final events = controller.sampleEvents;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                DaDtaCalender.instance.dataCalender.forEach((element) {
                  print(element);
                });
              },
              icon: Icon(Icons.check))
        ],
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
      ),
      body: GetBuilder<CalenderViewModel>(
        init: CalenderViewModel(),
        builder: (CalenderViewModel controllerss) {
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
              final controllerDetail = Get.find<DetailViewModel>();
              controllerDetail.getDataDetail(
                  date: date,
                  eventsOnTheDate: eventsOnTheDate,
                  context: context);
            },
            onPageChanged: (firstDate, lastDate) {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            controller.resetValue();
            context.push("/addNote");
          }),
    );
  }
}
