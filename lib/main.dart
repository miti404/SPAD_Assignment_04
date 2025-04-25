import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter App",
      themeMode: ThemeMode.system, // Use system theme mode
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(95, 245, 48, 97),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(96, 230, 140, 163),
            fontSize: 18,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(95, 245, 48, 97),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(96, 230, 140, 163),
            fontSize: 18,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
