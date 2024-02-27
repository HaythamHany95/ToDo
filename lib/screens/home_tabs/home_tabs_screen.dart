import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/settings/settings_tab.dart';
import 'package:to_do_app/screens/home_tabs/tasks/tasks_tab.dart';
import 'package:to_do_app/screens/home_tabs/widgets/notched_navbar.dart';

class HomeTabsScreen extends StatefulWidget {
  static const String routeName = "home_tabs_screen";

  const HomeTabsScreen({super.key});

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  /// [ MARK ] Variables: -
  int _selectedTabIndex = 0;

  /// [ MARK ] Stf LifeCycle: -
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        titleSpacing: MediaQuery.of(context).size.width * 0.15,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
      ),
      bottomNavigationBar: NotchedBottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (newIndex) {
          _selectedTabIndex = newIndex;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_list.png")),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_settings.png")),
              label: "")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _selectedTabIndex == 0 ? const TasksTab() : const SettingsTab(),
    );
  }
}
