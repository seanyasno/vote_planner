import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:flutter/material.dart';
import 'config/config.dart';

void main() {
  Supabase(
    url: const String.fromEnvironment('SUPABASE_URL', defaultValue: ''),
    anonKey: const String.fromEnvironment('SUPABASE_ANONKEY', defaultValue: ''),
    debug: const bool.fromEnvironment('SUPABASE_DEBUG', defaultValue: false),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vote Planner',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: PlannerPage(),
    );
  }
}
