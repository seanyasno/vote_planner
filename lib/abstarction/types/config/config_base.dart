abstract class ConfigBase {
  final bool useMock = const bool.fromEnvironment('USE_MOCK', defaultValue: false);
  SupabaseConfig get supabase {
    return SupabaseConfig(
      url: const String.fromEnvironment('SUPABASE_URL', defaultValue: ''), 
      anonKey: const String.fromEnvironment('SUPABASE_ANONKEY', defaultValue: ''), 
      debug: const bool.fromEnvironment('SUPABASE_DEBUG', defaultValue: false),
    );
  }
}

class SupabaseConfig  {
  String url;
  String anonKey;
  bool debug;

  SupabaseConfig({required this.url, required this.anonKey, required this.debug});
}