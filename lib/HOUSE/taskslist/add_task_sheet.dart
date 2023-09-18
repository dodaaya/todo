import 'package:flutter/material.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Add new task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'enter task title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                    '17',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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

  void showCalendar() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
  }
}
