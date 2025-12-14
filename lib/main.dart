import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/env/app_env.dart';
import 'package:mobile/core/extensions/log_extension.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/services/app_logger.dart';
import 'package:mobile/core/routing/app_router.dart';
import 'package:mobile/core/widgets/animated_loader_widget.dart';
import 'package:mobile/features/aap_language/providers/language_provider.dart';
import 'package:mobile/features/app_appearance/theme/theme.dart';
import 'package:mobile/features/app_appearance/util/util.dart';
import 'package:mobile/features/app_appearance/providers/theme_provider.dart';
import 'package:mobile/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Supabase FIRST, before DI
  try {
    // Validate environment variables
    AppEnv.validateEnv();

    ("Initializing Supabase with URL: ${appEnv.supabaseUrl}").log();
    ("Anonymous key length: ${appEnv.supabaseAnonKey.length}").log();

    await Supabase.initialize(
      url: appEnv.supabaseUrl,
      anonKey: appEnv.supabaseAnonKey,
    );
    ("Supabase initialized successfully").log();
  } catch (e, stackTrace) {
    ("Error initializing Supabase: $e").log();
    ("Stack trace: $stackTrace").log();
  }

  await initApp();

  runApp(
    ProviderScope(
      //observers: kDebugMode ? [RiverpodDebugObserver()] : [],
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

Future initApp() async {
  // Initialize file logging
  await AppLogger.instance.initialize();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Log.configureLogger();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..textColor = Colors.black
    ..radius = 20
    ..backgroundColor = Colors.transparent
    ..maskColor = Colors.white
    ..indicatorColor = Colors.black54
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorWidget = AnimatedLoaderWidget()
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(currentLanguageProvider);

    // Create text theme with Poppins font
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme materialTheme = MaterialTheme(textTheme);

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale,
      title: 'Muslim365',
      debugShowCheckedModeBanner: false,

      // Theme Configuration using Material Theme Builder
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
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
