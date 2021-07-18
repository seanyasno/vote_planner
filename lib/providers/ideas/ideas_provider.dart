import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:flutter/foundation.dart';

class IdeasProvider with ChangeNotifier {
  List<Idea> _ideas;

  IdeasProvider(this._ideas);

  List<Idea> get ideas => _ideas;

  List<Idea> addIdea({required Idea newIdea}) {
    _ideas.add(newIdea);
    notifyListeners();
    return _ideas;
  }

  List<Idea> resetIdeas({required List<Idea> newIdeas}) {
    _ideas = newIdeas;
    notifyListeners();
    return _ideas;
  }
}
