import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/task_textformfied.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit_task_screen';

  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  ///* [ MARK ] variables
  final _formKey = GlobalKey<FormState>();

  ///* [ MARK ] STF Life Cycle
  @override
  Widget build(BuildContext context) {
    var taskArgs = ModalRoute.of(context)?.settings.arguments as Task;
    var taskProvider = Provider.of<TasksProvider>(context);
    var currentAuthUserId =
        Provider.of<AuthUserProvider>(context).currentAuthUser!.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
      ),
      body: Stack(children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.primaryColor, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.08, 0.08]),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                decoration: BoxDecoration(
                    color: MyTheme.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Form(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 30, right: 30, left: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Edit Task",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TaskTextFormField(
                          key: _formKey,
                          initialValue: taskArgs.title,
                          onChanged: (newText) {
                            taskArgs.title = newText;
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
                          initialValue: taskArgs.desc,
                          onChanged: (newText) {
                            taskArgs.desc = newText;
                          },
                          hintText: "enter Task Description",
                          maxLines: 4,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 50),
                                foregroundColor: MyTheme.whiteColor,
                                backgroundColor: MyTheme.primaryColor,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 18)),
                            onPressed: () {
                              FirebaseManager.updateTaskFromFirestore(
                                      taskArgs, currentAuthUserId!)

                                  /// When application is `offline`
                                  .timeout(Durations.medium4, onTimeout: () {
                                taskProvider.getAllTasks(currentAuthUserId);
                                // Navigator.pop(context);
                                ///
                                ///! Error from [context] here,
                                /// remove one of those contexts and it works
                                ///
                                /// When application is `offline`
                              }).then((_) {
                                taskProvider.getAllTasks(currentAuthUserId);
                                Navigator.pop(context);
                              });
                            },
                            child: const Text("Save Changes"))
                      ]),
                ))))
      ]),
    );
  }
}
