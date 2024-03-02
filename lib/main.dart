import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: ThemeMode.system,
      initialRoute: HomeTabsScreen.routeName,
      routes: {
        HomeTabsScreen.routeName: (context) => const HomeTabsScreen(),
      },
    );
  }
}
