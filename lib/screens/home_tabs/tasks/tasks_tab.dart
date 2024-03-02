import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/taskitem_listtile.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  /// [ MARK ] variables
  final _calenderController = EasyInfiniteDateTimelineController();

  /// [ MARK ] STF Life Cycle
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: BoxDecoration(
            color: Colors.amber,
            gradient: LinearGradient(
                colors: [MyTheme.primaryColor, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.6]),
          ),

          ///* EasyInfiniteDateTimeLine
          child: EasyInfiniteDateTimeLine(
            timeLineProps: const EasyTimeLineProps(
                margin: EdgeInsets.only(top: 13),
                vPadding: 15,
                separatorPadding: 12,
                hPadding: 2),
            showTimelineHeader: false,
            dayProps: EasyDayProps(
                inactiveDayStyle: DayStyle(
              decoration: BoxDecoration(
                  color: MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(10)),
            )),
            controller: _calenderController,
            firstDate: DateTime.now(),
            focusDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {},
          ),
        ),

        /// Start of the original structre --------
        Container(
            height: MediaQuery.of(context).size.height * 0.612,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, i) => const TaskItemListTile(
                title: "Shopping",
                description: "Buy cheese from Ma'amon",
              ),
            ))),
      ],
    );
  }
}
