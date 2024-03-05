import 'package:flutter/material.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  /// Fetching All Tasks from Firestore.
  /// Every time make CRUD using it to reload date
  void getAllTasks() async {
    var querySnapshot = await FirebaseManager.getTasksCollection().get();
    tasks = querySnapshot.docs.map((document) => document.data()).toList();
    notifyListeners();
  }

  /// Making the `CurrentDate` on the calender to the day chosen by the `User`
  void changeDateOnCalender(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }
}
