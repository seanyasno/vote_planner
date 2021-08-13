import 'package:shared_preferences/shared_preferences.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserProvider({user}) {
    _user = user;
  }

  Future<User?> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? '';
    final userName = prefs.getString('user_name') ?? '';

    if (userId.isNotEmpty && userName.isNotEmpty) {
      _user = User(id: userId, name: userName);
      return _user;
    }

    return null;
  }

  Future<User> setUser({required User user}) async {
    _user = user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', user.id!);
    prefs.setString('user_name', user.name!);
    notifyListeners();
    return _user!;
  }

  Future<void> removeUser() async {
    _user = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    prefs.remove('user_name');
    notifyListeners();
  }
}
