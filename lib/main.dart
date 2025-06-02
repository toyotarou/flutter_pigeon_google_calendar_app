import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false, colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)),
      themeMode: ThemeMode.dark,
      title: 'Google Calendar App',

      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
