import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/task.dart';

class FirebaseManager {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter<Task>(
      /// from [json] to [object]
      fromFirestore: (snapshot, _) {
        return Task.fromJson(snapshot.data()!);
      },

      /// from [object] to [json]
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTaskToFirestore(Task task) {
    CollectionReference tasksCollection = getTasksCollection();
    DocumentReference taskDocument = tasksCollection.doc();

    /// to set the auto generate's [taskDocument.id] to task id, so `user` doesn't set it by himself
    task.id = taskDocument.id;

    return taskDocument.set(task);
  }
}
