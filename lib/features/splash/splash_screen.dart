import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/pref_keys.dart';
import 'package:mobile/core/extensions/log_extension.dart';
import 'package:mobile/core/notifications/notification_service.dart';
import 'package:mobile/core/routing/app_routes.dart';
import 'package:mobile/core/utils/shared_preferences_keys.dart';
import 'package:mobile/features/app_appearance/extensions/widget_animation_extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isLoading = false;
  String? _loadingMessage;

  @override
  void initState() {
    super.initState();
    initializeServices();
    makeIsLoadingTrueAfterLittleDelay();
    _navigateToOnboarding();
  }

  Future<void> initializeServices() async {
    await NotificationServices.instance.initialize();
  }

  Future<bool?> _hasCompletedOnboarding() async {
    try {
      final prefs = SharedPreferencesKeys();
      final onboardingStatus = await prefs.getIntData(
        key: isShowOnBoardingView,
      );

      // Convert int to bool: 1 = true, 0 = false, null = false
      if (onboardingStatus == null) return false;
      return onboardingStatus == 1;
    } catch (e) {
      return false;
    }
  }

  Future<void> makeIsLoadingTrueAfterLittleDelay() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() => _isLoading = true);
  }

  Future<void> _navigateAfterDelay(String route, String state) async {
    "I am navigating from the State: $state".log();
    // Ensure minimum loading time for smooth UX
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) context.go(route);
  }

  Future<void> _navigateToOnboarding() async {
    if (await _hasCompletedOnboarding() != true) {
      if (mounted) {
        await _navigateAfterDelay(
          AppRoutes.onboarding,
          "Navigating to Onboarding",
        );
      }
    } else {
      await _navigateAfterDelay(
        AppRoutes.onboarding,
        "Navigating to Onboarding",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/muslim365-app-icon.svg',
              width: 100,
              height: 100,
            ).animateWidget(),

            const SizedBox(height: 20),

            Text(
              'Muslim365',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).animateWidget(),

            const SizedBox(height: 40),

            // show while state is loading after data is loaded only then navigate away
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 24),

              // Loading message with fade animation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _loadingMessage ?? 'Loading...',
                  key: ValueKey(_loadingMessage),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
