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

  static Future<List<Planner>> getPlannersByUserId(
      {required String userId}) async {
    try {
      final response = await Supabase()
          .client
          .from('planner_users')
          .select('planners (*)')
          .eq('user_id', userId)
          .execute();

      if (response.error != null) {
        throw Error();
      }

      if (response.data.length == 0) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((element) => Planner.fromJson(element['planners']))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  static Future<Planner> addPlanner(
      {required String plannerTitle, required User user}) async {
    try {
      final response = await Supabase()
          .client
          .from('planners')
          .insert({'title': plannerTitle}).execute();

      if (response.error != null) {
        throw Error();
      }

      await Supabase().client.from('planner_users').insert({
        'planner_id': response.data[0]['id'],
        'user_id': user.id!,
      }).execute();

      return Planner.fromJson(response.data[0]);
    } catch (error) {
      throw error;
    }
  }
}
