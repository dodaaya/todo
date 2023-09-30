import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()!),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();
    var docReference = taskCollection.doc();
    task.id = docReference.id;
    return docReference.set(task);
  }
}
