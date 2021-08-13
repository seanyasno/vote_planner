import 'package:vote_planner/abstarction/abstraction.dart';

class DevelopmentConfig extends ConfigBase {
  @override
  bool get useMock => const bool.fromEnvironment('USE_MOCK', defaultValue: false);

  @override
  SupabaseConfig get supabase {
    return SupabaseConfig(
      url: const String.fromEnvironment('SUPABASE_URL', defaultValue: ''), 
      anonKey: const String.fromEnvironment('SUPABASE_ANONKEY', defaultValue: ''), 
      debug: const bool.fromEnvironment('SUPABASE_DEBUG', defaultValue: false),
    );
  }
}