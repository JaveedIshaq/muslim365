import 'package:envied/envied.dart';
import 'package:mobile/core/env/app_env.dart';
import 'package:mobile/core/env/app_env_fields.dart';

part 'uat_env.g.dart';

@Envied(name: 'Env', path: '.env.uat')
final class UatEnv implements AppEnv, AppEnvFields {
  UatEnv();

  @override
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  final String supabaseUrl = _Env.supabaseUrl;

  @override
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  final String supabaseAnonKey = _Env.supabaseAnonKey;

  @override
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  final String geminiApiKey = _Env.geminiApiKey;
}
