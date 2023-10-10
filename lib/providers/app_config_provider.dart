import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.dark;
  String appLanguage = 'en';
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getTasksFromFs(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList = tasksList.where((task) {
      if (task.dateTime?.day == selectDate.day &&
          task.dateTime?.month == selectDate.month &&
          task.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeSelDate(DateTime newDate, String uId) {
    selectDate = newDate;
    getTasksFromFs(uId);
  }
}
