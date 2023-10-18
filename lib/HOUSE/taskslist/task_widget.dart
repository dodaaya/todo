import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/HOUSE/taskslist/edit_task.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

class taskWidget extends StatefulWidget {
  Task task;

  taskWidget({required this.task});

  @override
  State<taskWidget> createState() => _taskWidgetState();
}

class _taskWidgetState extends State<taskWidget> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(editTask.routeName, arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseUtils.deleteTaskFromFs(
                          widget.task, authProvider.currentUser!.id!)
                      .timeout(Duration(milliseconds: 500), onTimeout: () {
                    print('deleted');
                    listProvider.getTasksFromFs(authProvider.currentUser!.id!);
                  });
                },
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                backgroundColor: MyTheme.redColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : Theme.of(context).primaryColor,
                  height: 80,
                  width: 4,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.description ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                )),
                InkWell(
                  onTap: () {
                    FirebaseUtils.editIsDone(
                        widget.task, authProvider.currentUser!.id!);
                    widget.task.isDone = !widget.task.isDone!;
                    setState(() {});
                  },
                  child: widget.task.isDone!
                      ? Text(
                          'Done!',
                          style: TextStyle(
                              color: MyTheme.greenColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: MyTheme.white,
                            size: 30,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
