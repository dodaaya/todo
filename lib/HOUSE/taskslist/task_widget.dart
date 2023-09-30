import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/task.dart';
import 'package:todo/myTheme.dart';

class taskWidget extends StatelessWidget {
  Task task;

  taskWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            backgroundColor: MyTheme.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('edit_task');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyTheme.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
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
                          .copyWith(color: Theme.of(context).primaryColor),
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
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.check,
                  color: MyTheme.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
