import 'package:envied/envied.dart';
import 'package:mobile/core/env/app_env.dart';
import 'package:mobile/core/env/app_env_fields.dart';

part 'release_env.g.dart';

@Envied(name: 'Env', path: '.env.release')
final class ReleaseEnv implements AppEnv, AppEnvFields {
  ReleaseEnv();

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
