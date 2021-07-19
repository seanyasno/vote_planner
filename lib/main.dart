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
          create: (_) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      title: 'Vote Planner',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: userProvider.init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PlannersPage();
          }

          if (snapshot.data == null) {
            return HomePage();
          }

          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
