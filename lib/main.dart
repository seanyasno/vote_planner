import 'package:vote_planner/abstarction/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vote_planner/providers/providers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'config/config.dart';

void main() {
  Supabase(
    url: const String.fromEnvironment('SUPABASE_URL', defaultValue: ''),
    anonKey: const String.fromEnvironment('SUPABASE_ANONKEY', defaultValue: ''),
    debug: const bool.fromEnvironment('SUPABASE_DEBUG', defaultValue: false),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            user: User(
              id: 'f381af3b-6cd8-4c0c-88f1-6cea5e4c9bef',
              name: 'Sean Yasno',
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
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
      home: HomePage(),
    );
  }
}
