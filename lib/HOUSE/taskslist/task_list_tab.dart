import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/HOUSE/taskslist/task_widget.dart';
import 'package:todo/myTheme.dart';

class taskListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              return taskWidget();
            },
            itemCount: 30,
          ),
        )
      ],
    );
  }
}
