// Collection -> Document -> date [set || read || delete || update task]
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/task.dart';

class FirebaseManager {
  /// To access the [Collection]
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
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
    CollectionReference<Task> tasksCollection = getTasksCollection();
    DocumentReference<Task> taskDocument = tasksCollection.doc();

    /// to set the auto generate's [taskDocument.id] to task id, so `user` doesn't set it by himself
    task.id = taskDocument.id;

    return taskDocument.set(task);
  }

  static Future<void> deleteFromFirestore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskFromFirestore(Task task) {
    return getTasksCollection()
        .doc(task.id)
        .update({'title': task.title, 'desc': task.desc});
  }
}
