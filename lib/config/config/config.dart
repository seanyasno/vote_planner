import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/abstarction/models/configs/development/development_config.dart';

class Config {
  static Config? _instance;
  late ConfigBase config;

  Config._internal() {
    const environment = const String.fromEnvironment('ENV', defaultValue: '');
    switch (environment) {
      case 'develop':
        config = DevelopmentConfig();
        break;
    }
  }

  static Config get instance {
    if (_instance == null) {
      _instance = Config._internal();
    }

    return _instance!;
  }
}
