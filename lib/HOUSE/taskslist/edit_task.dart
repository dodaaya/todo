import 'package:flutter/material.dart';
import 'package:todo/myTheme.dart';

class editTask extends StatelessWidget {
  static const String routeName = 'edit_task';
  String? mytitle;
  String? mydesc;

  editTask({this.mytitle, this.mydesc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 21,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: MyTheme.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter task title';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    mytitle = text;
                  },
                  decoration: InputDecoration(hintText: '$mytitle'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) {
                    mydesc = text;
                  },
                  decoration: InputDecoration(hintText: '$mydesc'),
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('select date',
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '27-6-2021',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(50, 50)),
                onPressed: () {},
                child: Text(
                  'save changes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
