import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HOUSE/taskslist/task_widget.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';

class taskListTab extends StatefulWidget {
  @override
  State<taskListTab> createState() => _taskListTabState();
}

class _taskListTabState extends State<taskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<AppConfigProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getTasksFromFs();
    }

    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: MyTheme.black,
          dayColor: MyTheme.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: MyTheme.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return taskWidget(
                task: listProvider.tasksList[index],
              );
            },
            itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }
}
