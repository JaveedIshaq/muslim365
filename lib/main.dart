import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/routing/app_router.dart';
import 'package:mobile/features/aap_language/models/language_model.dart';
import 'package:mobile/features/aap_language/providers/language_provider.dart';
import 'package:mobile/features/app_appearance/theme/app_theme.dart';
import 'package:mobile/features/app_appearance/providers/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(currentLanguageProvider);
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate, // Auto-generated
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: getLocalesFromLanguageModels(),
      locale: currentLocale,
      title: 'Muslim365',
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Router Configuration
      routerConfig: AppRouter.router,

      // Builder for global configurations
      builder: (context, child) {
        return MediaQuery(
          // Disable text scaling to maintain consistent UI
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}
