import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlannerController {
  static Future<List<Idea>> getIdeasByPlannerId(String plannerId) async {
    try {
      final response = await Supabase()
          .client
          .from('ideas')
          .select('*')
          .eq('planner_id', plannerId)
          .execute();

      if (response.error != null) {
        throw Error();
      }

      return (response.data as List<dynamic>)
          .map((idea) => Idea.fromJson(idea))
          .toList();
    } catch (error) {
      throw error;
    }
  }
}
