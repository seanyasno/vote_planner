import 'package:flutter/cupertino.dart';
import 'package:vote_planner/abstarction/abstraction.dart';

class PlannersProvider with ChangeNotifier {
  List<Planner> _planners;

  PlannersProvider(this._planners);

  List<Planner> get planners => _planners;

  List<Planner> resetPlanners({required List<Planner> newPlanners}) {
    _planners = newPlanners;
    notifyListeners();
    return _planners;
  }
}
