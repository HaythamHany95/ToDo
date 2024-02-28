import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class TaskItemListTile extends StatelessWidget {
  final String title;
  final String? description;
  const TaskItemListTile({required this.title, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 0,
      color: MyTheme.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Container(
            margin: const EdgeInsets.only(left: 5),
            width: 4,
            color: MyTheme.primaryColor,
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: MyTheme.primaryColor),
          ),
          subtitle: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(description ?? "")),
          trailing: Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                /// TODO: make title's color green and the Widget into Text ("Done!")
                // print("button pressed");
              },
              child: ImageIcon(
                const AssetImage("assets/images/icon_check.png"),
                color: MyTheme.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
