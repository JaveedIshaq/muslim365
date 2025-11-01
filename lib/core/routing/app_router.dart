import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/app_appearance/app_appearance_screen.dart';
// import 'package:mobile/features/splash/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'app-appearance',
        builder: (context, state) => const AppAppearanceScreen(),
      ),
      // GoRoute(
      //   path: SplashScreen.route,
      //   builder: (context, state) => const SplashScreen(),
      // ),
      // GoRoute(
      //   path: OnBoardingScreen.route,
      //   builder: (context, state) => const OnBoardingScreen(),
      // ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

// VideoDetailsScreen placeholder removed - using VideoDetailViewScreen instead

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('Page not found')),
    );
  }
}
