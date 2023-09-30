import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/providers/app_config_provider.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late AppConfigProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Add new task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'enter task title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task description';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(hintText: 'enter task description'),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('select date',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      FirebaseUtils.addTaskToFireStore(task)
          .timeout(Duration(milliseconds: 500), onTimeout: () {
        listProvider.getTasksFromFs();
        Navigator.pop(context);
      });
    }
  }
}
