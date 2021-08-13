import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/providers/providers.dart';

class UserProviderMock extends UserProvider {
  User? _user;

  User? get user => _user;

  UserProviderMock({user}) {
    _user = user;
  }

  @override
  Future<User?> init() async {
    return _user;
  }

  @override
  Future<User> setUser({required User user}) async {
    _user = user;
    notifyListeners();
    return _user!;
  }

  @override
  Future<void> removeUser() async {
    _user = null;
    notifyListeners();
  }
}
