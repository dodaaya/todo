import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Dia;ogue_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

class editTask extends StatefulWidget {
  static const String routeName = 'edit_task';

  @override
  State<editTask> createState() => _editTaskState();
}

class _editTaskState extends State<editTask> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late AppConfigProvider listProvider;
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
  Task? task;

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      var task = ModalRoute.of(context)?.settings.arguments as Task;
      titlecontroller.text = task!.title ?? '';
      desccontroller.text = task!.description ?? '';
      selectedDate = task!.dateTime!;
    }
    listProvider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: MyTheme.primaryLight,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04),
              decoration: BoxDecoration(
                  color: MyTheme.white,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    'Edit task',
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
                              controller: titlecontroller,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'please enter task title';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(hintText: 'enter task title'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: desccontroller,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'please enter task description';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'enter task description'),
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
                              editTask();
                            },
                            child: Text(
                              'save changes',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate, //or DateTime.now()
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void editTask() {
    if (formKey.currentState?.validate() == true) {
      task?.title = titlecontroller.text;
      task?.description = desccontroller.text;
      task?.dateTime = selectedDate;
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      DialogueUtils.showLoading(context, 'loading...');

      FirebaseUtils.editTask(task!, authProvider.currentUser!.id!)
          .then((value) {
        DialogueUtils.hideLoading(context);
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('success');
        listProvider.getTasksFromFs(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
