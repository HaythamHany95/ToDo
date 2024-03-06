import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/add_button.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/task_textformfied.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class NewTaskBottomSheet extends StatefulWidget {
  const NewTaskBottomSheet({super.key});

  @override
  State<NewTaskBottomSheet> createState() => _NewTaskBottomSheetState();
}

class _NewTaskBottomSheetState extends State<NewTaskBottomSheet> {
  /// [ MARK ] Variables: -
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  String? _taskTitle;
  String? _taskDesc;
  late TasksProvider _tasksProvider;

  /// [ MARK ] Utilities: -
  void _showCalender() async {
    var calenderDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (calenderDate != null) {
      _selectedDate = calenderDate;
    }
    setState(() {});
  }

  void _addTask() {
    Task newTask =
        Task(title: _taskTitle, desc: _taskDesc, date: _selectedDate);
    FirebaseManager.addTaskToFirestore(newTask)
        .timeout(const Duration(milliseconds: 500), onTimeout: () {
      _tasksProvider.getAllTasks();
    });
  }

  /// [ MARK ] Stf Life Cycle: -
  @override
  Widget build(BuildContext context) {
    _tasksProvider = Provider.of<TasksProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
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
              onChanged: (newText) {
                _taskTitle = newText;
                setState(() {});
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "You should enter your Task ";
                }
                return null;
              },
              hintText: "enter Your Task",
            ),
            TaskTextFormField(
              onChanged: (newText) {
                _taskDesc = newText;
                setState(() {});
              },
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
                _showCalender();
              },
              child: Text(
                "${_selectedDate?.year}-${_selectedDate?.month}-${_selectedDate?.day}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyTheme.greyDarkColor),
              ),
            ),
            CircleElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addTask();
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
