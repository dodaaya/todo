import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HOUSE/settings/settings_tab.dart';
import 'package:todo/HOUSE/taskslist/add_task_sheet.dart';
import 'package:todo/HOUSE/taskslist/task_list_tab.dart';
import 'package:todo/authentication/login/login_screen.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List ${authProvider.currentUser!.name}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
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
