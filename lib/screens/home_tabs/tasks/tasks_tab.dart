import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/calender.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/taskitem_listtile.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  /// [ MARK ] variables
  late TasksProvider _tasksProvider;

  final _calenderController = EasyInfiniteDateTimelineController();

  /// [ MARK ] STF Life Cycle
  @override
  Widget build(BuildContext context) {
    _tasksProvider = Provider.of<TasksProvider>(context);
    if (_tasksProvider.tasks.isEmpty) {
      _tasksProvider.getAllTasks();
    }
    return Column(
      children: [
        Calender(
          controller: _calenderController,
          firstDate: DateTime.now(),
          focusDate: _tasksProvider.selectedDate,
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateChange: (selectedDate) {
            _tasksProvider.changeDateOnCalender(selectedDate);
            print(selectedDate);
          },
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.612,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Expanded(
                child: ListView.builder(
              itemCount: _tasksProvider.tasks.length,
              itemBuilder: (context, i) => TaskItemListTile(
                title: _tasksProvider.tasks[i].title ?? "",
                description: _tasksProvider.tasks[i].desc,
              ),
            ))),
      ],
    );
  }
}
