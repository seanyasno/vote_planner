import 'package:vote_planner/abstarction/abstraction.dart';

class DevelopmentConfig extends ConfigBase {
  @override
  bool get useMock => const bool.fromEnvironment('USE_MOCK', defaultValue: false);
}