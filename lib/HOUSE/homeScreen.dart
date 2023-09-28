import 'package:flutter/material.dart';
import 'package:todo/HOUSE/settings/settings_tab.dart';
import 'package:todo/HOUSE/taskslist/add_task_sheet.dart';
import 'package:todo/HOUSE/taskslist/task_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'tasks list'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showaddTask();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [taskListTab(), SettingsTab()];

  void showaddTask() {
    showModalBottomSheet(
        context: context, builder: ((context) => AddTaskSheet()));
  }
}
