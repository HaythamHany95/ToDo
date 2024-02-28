import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/add_button.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/task_textformfied.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class NewTaskBottomSheet extends StatelessWidget {
  const NewTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
      width: double.infinity,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const TaskTextFormField(
              hintText: "enter Your Task ",
            ),
            const TaskTextFormField(
              hintText: "enter Task Description",
              maxLines: 4,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Date",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              child: Text(
                "11/12/2024",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyTheme.greyDarkColor),
              ),
            ),
            CircleElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
