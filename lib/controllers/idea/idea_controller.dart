import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IdeaController {
  static Future<List<User>> getUsersByIdeaId(String ideaId) async {
    try {
      final response = await Supabase()
          .client
          .from('idea_voters')
          .select('users (*)')
          .eq('idea_id', ideaId)
          .execute();

      if (response.error != null) {
        throw Error();
      }

      if (response.data.length == 0) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((user) => User.fromJson(user['users']))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  static Future upvoteIdea(String ideaId, String userId) async {
    try {
      final response = await Supabase().client.from('idea_voters').insert({
        'idea_id': ideaId,
        'user_id': userId,
      }).execute();

      if (response.error != null) {
        throw Error();
      }
    } catch (error) {
      throw error;
    }
  }

  static Future removeVote({required ideaId, required userId}) async {
    try {
      final response = await Supabase()
          .client
          .from('idea_voters')
          .delete()
          .eq('idea_id', ideaId)
          .eq('user_id', userId)
          .execute();

      if (response.error != null) {
        throw Error();
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Idea> addIdea({required Idea idea}) async {
    try {
      final response = await Supabase().client.from('ideas').insert({
        'planner_id': idea.plannerId,
        'user_id': idea.userId,
        'description': idea.description,
      }).execute();

      if (response.error != null) {
        throw Error();
      }

      return Idea.fromJson(response.data[0]);
    } catch (error) {
      throw error;
    }
  }
}
