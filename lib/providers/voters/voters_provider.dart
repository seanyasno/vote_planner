import 'package:flutter/cupertino.dart';
import 'package:vote_planner/abstarction/abstraction.dart';

class VotersProvider with ChangeNotifier {
  List<User> _voters;

  VotersProvider(this._voters);

  List<User> get voters => _voters;

  List<User> resetVoters({required List<User> newVoters}) {
    _voters = newVoters;
    notifyListeners();
    return _voters;
  }

  void removeVoter({required String userId}) {
    _voters.removeWhere((user) => user.id == userId);
    notifyListeners();
  }
}
