import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/widgets/bottom_sheet/task_textformfied.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = 'edit_task_screen';

  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
      ),
      body: Stack(children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              gradient: LinearGradient(
                  colors: [MyTheme.primaryColor, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.08, 0.08]),
            ),
            child: Positioned(
                top: 20,
                bottom: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.12),
                    decoration: BoxDecoration(
                        color: MyTheme.whiteColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Form(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Edit Task",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TaskTextFormField(
                              onChanged: (newText) {},
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "You should enter your Task ";
                                }
                                return null;
                              },
                              hintText: "enter Your Task",
                            ),
                            TaskTextFormField(
                              onChanged: (newText) {},
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
                                // _showCalender();
                              },
                              child: Text(
                                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: MyTheme.greyDarkColor),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Save Changes"))
                          ]),
                    )))))
      ]),
    );
  }
}
