import 'package:mobile/core/env/app_env_fields.dart';
import 'package:mobile/core/env/dev_env.dart';
import 'package:mobile/core/env/release_env.dart';
import 'package:mobile/core/env/uat_env.dart';
import 'package:mobile/core/extensions/log_extension.dart';

abstract interface class AppEnv implements AppEnvFields {
  factory AppEnv() => _instance;

  static const AppFlavor flavor =
      String.fromEnvironment('app.flavor') == "prod"
          ? AppFlavor.PROD
          : String.fromEnvironment('app.flavor') == "uat"
          ? AppFlavor.UAT
          : AppFlavor.DEV;

  static final AppEnv _instance =
      flavor == AppFlavor.PROD
          ? ReleaseEnv()
          : flavor == AppFlavor.UAT
          ? UatEnv()
          : DevEnv();

  // Ensure we have valid Supabase credentials
  static void validateEnv() {
    final env = AppEnv();
    if (env.supabaseUrl.isEmpty || env.supabaseAnonKey.isEmpty) {
      ("WARNING: Supabase credentials are missing or empty!").log();
      ("URL: ${env.supabaseUrl}").log();
      ("Key length: ${env.supabaseAnonKey.length}").log();
    }
  }
}

var appEnv = AppEnv();

enum AppFlavor {
  DEV,
  UAT,
  PROD;

  bool get isDev => AppEnv.flavor == AppFlavor.DEV;

  bool get isUat => AppEnv.flavor == AppFlavor.UAT;

  bool get isProd => AppEnv.flavor == AppFlavor.PROD;
}
