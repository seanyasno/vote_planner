import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vote_planner/abstarction/abstraction.dart';

class UserController {
  static Future<User> insertUser({required String name}) async {
    try {
      final response = await Supabase()
          .client
          .from('users')
          .insert({'name': name}).execute();

      if (response.error != null) {
        throw Error();
      }

      print(response.data[0]);

      return User.fromJson(response.data[0]);
    } catch (error) {
      throw error;
    }
  }
}
