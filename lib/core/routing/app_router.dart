import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/app_routes.dart';
import 'package:mobile/core/routing/error_screen.dart';
import 'package:mobile/features/app_appearance/app_appearance_screen.dart';
import 'package:mobile/features/banner/presentation/screens/banner_screen.dart';
import 'package:mobile/features/onboarding/view/onboarding_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';
export 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    routes: [
      // App Entry & Navigation Routes
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnBoardingScreen(),
      ),

      GoRoute(
        path: AppRoutes.banner,
        builder: (context, state) => const BannerScreen(),
      ),

      GoRoute(
        path: AppRoutes.appAppearance,
        name: 'app-appearance-screen',
        builder: (context, state) => const AppAppearanceScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(routerInfo: state),
  );
}
