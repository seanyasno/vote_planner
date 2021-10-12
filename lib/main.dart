import 'package:vote_planner/mocks/providers/providers.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vote_planner/providers/providers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'config/config.dart';

void main() {
  final useMock = Config.instance.config.useMock;

  Supabase.initialize(
    url: Config.instance.config.supabase.url,
    anonKey: Config.instance.config.supabase.anonKey,
    debug: Config.instance.config.supabase.debug,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => useMock
              ? UserProviderMock(
                  user: User(
                      id: '3b0a23d8-a4ba-4b30-852e-9f24a19b7c8d',
                      name: 'Test User'))
              : UserProvider(),
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
