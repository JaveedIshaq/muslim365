import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme_constants.dart';

/// Extension methods for common widget animations
extension WidgetAnimations on Widget {
  /// Animates a bottom sheet sliding up from bottom with fade in
  Widget animateBottomSheetEntrance() {
    return animate()
        .slideY(
          begin: ThemeConstants.slideYBegin,
          end: ThemeConstants.slideYEnd,
          duration: ThemeConstants.bottomSheetAnimationDuration.ms,
          curve: Curves.easeOut,
        )
        .fadeIn(duration: ThemeConstants.fadeInDuration.ms);
  }

  /// Animates a header with fade in and slide from top
  Widget animateHeaderEntrance({int delayMs = 0}) {
    return animate()
        .fadeIn(
          duration: ThemeConstants.headerAnimationDuration.ms,
          delay: Duration(milliseconds: delayMs),
        )
        .slideY(
          begin: ThemeConstants.headerSlideYBegin,
          end: ThemeConstants.slideYEnd,
          duration: ThemeConstants.headerAnimationDuration.ms,
          delay: Duration(milliseconds: delayMs),
        );
  }

  /// Animates a list item with slide from side and fade in
  Widget animateListItemEntrance({
    required int index,
    int baseDelayMs = ThemeConstants.optionAnimationDelay,
    int staggerDelayMs = ThemeConstants.optionStaggerDelay,
  }) {
    final totalDelay = baseDelayMs + (index * staggerDelayMs);
    return animate()
        .slideX(
          begin: ThemeConstants.slideXBegin,
          end: ThemeConstants.slideXEnd,
          duration: ThemeConstants.optionAnimationDuration.ms,
          delay: Duration(milliseconds: totalDelay),
        )
        .fadeIn(
          duration: ThemeConstants.optionAnimationDuration.ms,
          delay: Duration(milliseconds: totalDelay),
        );
  }

  /// Animates a selection indicator with scale effect
  Widget animateSelection({bool isSelected = false}) {
    return animate(target: isSelected ? 1 : 0).scale(
      end: const Offset(
        ThemeConstants.selectionScaleEnd,
        ThemeConstants.selectionScaleEnd,
      ),
      duration: ThemeConstants.selectionAnimationDuration.ms,
    );
  }
}

/// Extension methods for list of widgets animations
extension ListWidgetAnimations on List<Widget> {
  /// Animates a list of settings options with fade in and slide from bottom
  List<Widget> animateSettingsOptions() {
    return animate(interval: 100.ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.2, end: ThemeConstants.slideYEnd, duration: 300.ms);
  }
}

/// Extension methods for list of widgets animations
extension WidgetItemAnimations on Widget {
  /// Animates a list of settings options with fade in and slide from bottom
  Widget animateWidget() {
    return animate()
        .fadeIn(duration: 800.ms, delay: 200.ms)
        .slideY(begin: 0.5, end: 0, duration: 800.ms, delay: 200.ms);
  }
}
