import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/taskitem_listtile.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Expanded(
            child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) => const TaskItemListTile(
            title: "Shopping",
            description: "Buy cheese from Ma'amon",
          ),
        )));
  }
}
