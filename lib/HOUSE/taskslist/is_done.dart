import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

class IsDone extends StatelessWidget {
  Task task;
  static const String routeName = 'IS_DONE';

  IsDone({required this.task});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFs(
                        task, authProvider.currentUser!.id!)
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
                color: MyTheme.greenColor,
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
                      task.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.greenColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      task.description ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyTheme.white,
                ),
                child: Text(
                  'is Done!',
                  style: TextStyle(color: MyTheme.greenColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
