import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class NotchedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final void Function(int)? onTap;
  const NotchedBottomNavigationBar(
      {required this.currentIndex,
      required this.items,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 10),
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 12,
      color: MyTheme.whiteColor,
      child: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: items),
    );
  }
}
