import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/add_button.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/task_textformfied.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:intl/intl.dart';

class NewTaskBottomSheet extends StatefulWidget {
  const NewTaskBottomSheet({super.key});

  @override
  State<NewTaskBottomSheet> createState() => _NewTaskBottomSheetState();
}

class _NewTaskBottomSheetState extends State<NewTaskBottomSheet> {
  /// [ MARK ] Variables: -
  final _formKey = GlobalKey<FormState>();
  String? _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  /// [ MARK ] Utilities: -
  void showCalender() async {
    var calenderDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (calenderDate != null) {
      _selectedDate = DateFormat('yyyy-MM-dd').format(calenderDate);
    }
    setState(() {});
  }

  /// [ MARK ] Stf Life Cycle: -

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
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TaskTextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "You should enter your Task ";
                }
                return null;
              },
              hintText: "enter Your Task",
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
              onTap: () {
                showCalender();
              },
              child: Text(
                "$_selectedDate",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyTheme.greyDarkColor),
              ),
            ),
            CircleElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}