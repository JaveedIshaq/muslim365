// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/pref_keys.dart';
import 'package:mobile/core/extensions/log_extension.dart';
import 'package:mobile/core/routing/app_routes.dart';
import 'package:mobile/core/widgets/buttons/app_custom_button.dart';
import 'package:mobile/features/onboarding/view/page_pop_view.dart';
import 'package:mobile/features/onboarding/widgets/onboarding_gradient_decoration.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// ✅ CONSOLIDATED: OnBoardingScreen using Riverpod state management
///
/// This widget demonstrates the proper Riverpod pattern following the consolidated
/// architecture with Material 3 theming and full internationalization support.
/// It handles the multi-step onboarding flow with smooth page transitions
/// and proper accessibility features.
class OnBoardingScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [OnBoardingScreen].
  const OnBoardingScreen({super.key});

  /// Pushes the [OnBoardingScreen] widget to the navigation stack.
  static Future<T?> push<T extends Object?>(BuildContext context) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
    );
  }

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);
  var currentSlideIndex = 0;
  bool dontShowCheckBox = false;
  final bool _isConfirming = false;
  // to prevent double tap while in process to check location and navigate

  @override
  void initState() {
    super.initState();
    // Initialize page view data after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePageViewData();
    });
  }

  /// Initializes page view data with localized content
  void _initializePageViewData() {
    final l10n = AppLocalizations.of(context)!;
    pageViewModelData = [
      PageViewData(
        title: l10n.onBoardingSlideOneTitle,
        description: l10n.onBoardingSlideOneDesc,
        img: "assets/images/onboarding/onbaording-1.jpg",
      ),
      PageViewData(
        title: l10n.onBoardingSlideTwoTitle,
        description: l10n.onBoardingSlideTwoDesc,
        img: "assets/images/onboarding/onbaording-2.jpg",
      ),
      PageViewData(
        title: l10n.onBoardingSlideThreeTitle,
        description: l10n.onBoardingSlideThreeDesc,
        img: "assets/images/onboarding/onbaording-3.png",
      ),
      PageViewData(
        title: l10n.onBoardingSlideFourTitle,
        description: l10n.onBoardingSlideFourDesc,
        img: "assets/images/onboarding/onbaording-4.jpg",
      ),
      PageViewData(
        title: l10n.onBoardingSlideFiveTitle,
        description: l10n.onBoardingSlideFiveDesc,
        img: "assets/images/onboarding/onbaording-5.jpg",
      ),
      PageViewData(
        title: l10n.onBoardingSlideSixTitle,
        description: l10n.onBoardingSlideSixDesc,
        img: "assets/images/onboarding/onbaording-6.jpg",
      ),
      PageViewData(
        title: l10n.onBoardingSlideSevenTitle,
        description: l10n.onBoardingSlideSevenDesc,
        img: "assets/images/onboarding/onbaording-7.jpg",
      ),
    ];
    if (mounted) {
      setState(() {});
    }
  }

  /// Page view data will be initialized in _initializePageViewData
  List<PageViewData> pageViewModelData = [];

  void _goToNextPage() {
    final currentPage = _pageController.page?.toInt() ?? 0;
    final nextPage = currentPage + 1;

    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    // at first swipe back swipedBackCount is 0
    // swipe back and increases swipedBackCount by one

    final currentPage = _pageController.page?.toInt() ?? 0;
    final previousPage = currentPage - 1;
    if (previousPage >= 0) {
      _pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    //sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: OnboardingGradientDecoration(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(child: _buildPageView()),
              _buildPageIndicator(),
              _buildNavigationButtons(l10n, textTheme),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the main page view with onboarding slides
  Widget _buildPageView() {
    if (pageViewModelData.isEmpty) {
      return const SizedBox.shrink();
    }

    return PageView.builder(
      controller: _pageController,
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          currentSlideIndex = index;
        });
      },
      scrollDirection: Axis.horizontal,
      itemCount: pageViewModelData.length,
      itemBuilder: (context, index) {
        return PagePopup(onBoardingSlideData: pageViewModelData[index]);
      },
    );
  }

  /// Builds the page indicator with Material 3 theming
  Widget _buildPageIndicator() {
    if (pageViewModelData.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: pageViewModelData.length,
        effect: ExpandingDotsEffect(
          activeDotColor: colorScheme.primary,
          dotColor: colorScheme.outline.withValues(alpha: 0.4),
          dotHeight: 8.0,
          dotWidth: 8.0,
          spacing: 6.0,
        ),
        onDotClicked: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  /// Builds navigation buttons with proper Material 3 styling and localization
  Widget _buildNavigationButtons(AppLocalizations l10n, TextTheme textTheme) {
    if (pageViewModelData.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: currentSlideIndex == 0
          ? _buildFirstSlideButtons(l10n, colorScheme)
          : _buildSubsequentSlidesButtons(l10n, colorScheme, textTheme),
    );
  }

  /// Builds buttons for the first slide (Next and Skip)
  Widget _buildFirstSlideButtons(
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        AppCustomButton(text: l10n.next, onPressed: _goToNextPage),
        const SizedBox(height: 10),
        _buildSkipButton(l10n.skip, colorScheme),
      ],
    );
  }

  /// Builds buttons for subsequent slides (Previous, Next/Confirm, and Skip)
  Widget _buildSubsequentSlidesButtons(
    AppLocalizations l10n,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final isLastSlide = currentSlideIndex + 1 == pageViewModelData.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppCustomButton(
                text: l10n.previous,
                onPressed: _goToPreviousPage,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: isLastSlide
                  ? AppCustomButton(
                      text: l10n.confirm,
                      onPressed: _isConfirming ? () {} : _completeOnboarding,
                    )
                  : AppCustomButton(text: l10n.next, onPressed: _goToNextPage),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildSkipButton(l10n.skip, colorScheme),
      ],
    );
  }

  /// Builds the skip button with proper styling and accessibility
  Widget _buildSkipButton(String text, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: _skipOnboarding,
      child: Text(
        text,
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Completes the onboarding flow and navigates to the main app
  void _completeOnboarding() {
    if (_isConfirming) return;

    setDontShowAgain(true, context);
    context.go(AppRoutes.login);
  }

  /// Skips the onboarding flow and navigates to the main app
  void _skipOnboarding() {
    setDontShowAgain(true, context);
    context.go(AppRoutes.login);
  }

  Future<void> setDontShowAgain(bool isDontShow, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (isDontShow) {
      await prefs.setInt(isShowOnBoardingView, 1);
    } else {
      await prefs.setInt(isShowOnBoardingView, 0);
    }

    var isShowOnBoarding = prefs.getInt(isShowOnBoardingView);
    ("isShowOnBoarding: $isShowOnBoarding").log();
  }
}
