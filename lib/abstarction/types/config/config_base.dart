abstract class ConfigBase {
  abstract final bool useMock;
  abstract final SupabaseConfig supabase;
}

class SupabaseConfig  {
  String url;
  String anonKey;
  bool debug;

  SupabaseConfig({required this.url, required this.anonKey, required this.debug});
}