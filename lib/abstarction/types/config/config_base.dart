abstract class ConfigBase {
  abstract final bool useMock;
  abstract final SupabaseConfig supabase;
}

// abstract class SubpaseConfigType {
//   abstract final String url;
//   abstract final String anonKey;
//   abstract final bool debug;
// }

class SupabaseConfig  {
  String url;
  String anonKey;
  bool debug;

  SupabaseConfig({required this.url, required this.anonKey, required this.debug});
}