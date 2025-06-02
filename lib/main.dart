import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: always_specify_types
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const <Locale>[Locale('en'), Locale('ja')],
      theme: ThemeData(useMaterial3: false, colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)),
      themeMode: ThemeMode.dark,
      title: 'Google Calendar App',
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: GestureDetector(onTap: () => primaryFocus?.unfocus(), child: HomeScreen()),
    );
  }
}
