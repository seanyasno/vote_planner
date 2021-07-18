import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserProvider({user}) {
    _user = user;
  }

  void setUser({required User user}) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }
}
