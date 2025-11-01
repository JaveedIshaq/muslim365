import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';
import '../constants/theme_constants.dart';
import '../extensions/widget_animation_extensions.dart';
import '../models/theme_option.dart';
import '../providers/theme_provider.dart';
import 'theme_option_item.dart';


/// Theme Selection Bottom Sheet Widget
///
/// A modal bottom sheet that allows users to select between Light, Dark, and System themes.
/// Provides visual previews and immediate feedback for theme changes.
/// 
/// Usage:
/// ```dart
/// await ThemeSelectionBottomSheet.show(context);
/// ```
class ThemeSelectionBottomSheet extends ConsumerWidget {
  const ThemeSelectionBottomSheet({super.key});

  /// Shows the theme selection bottom sheet
  /// 
  /// Returns a Future that completes when the bottom sheet is closed.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => const ThemeSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeMode = ref.watch(themeModeProvider);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BottomSheetHandle(colorScheme: colorScheme),
          _BottomSheetHeader(colorScheme: colorScheme),
          _ThemeOptionsList(
            themeMode: themeMode,
            onThemeSelected: (mode) => _handleThemeSelection(context, mode, ref),
          ),
          _BottomPadding(),
        ],
      ),
    ).animateBottomSheetEntrance();
  }
}

/// Widget for the bottom sheet handle indicator
class _BottomSheetHandle extends StatelessWidget {
  const _BottomSheetHandle({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimensions.paddingSM),
      width: ThemeConstants.handleWidth,
      height: ThemeConstants.handleHeight,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: ThemeConstants.handleOpacity),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
      ),
    );
  }
}

/// Widget for the bottom sheet header
class _BottomSheetHeader extends StatelessWidget {
  const _BottomSheetHeader({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      child: Text(
        ThemeConstants.bottomSheetTitle,
        style: AppTypography.h5.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animateHeaderEntrance(delayMs: ThemeConstants.optionAnimationDelay);
  }
}

/// Widget for the list of theme options
class _ThemeOptionsList extends StatelessWidget {
  const _ThemeOptionsList({
    required this.themeMode,
    required this.onThemeSelected,
  });

  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Column(
        children: ThemeOptions.all.asMap().entries.map((entry) {
          final index = entry.key;
          final themeOption = entry.value;
          final isSelected = themeMode == themeOption.mode;

          return ThemeOptionItem(
            themeOption: themeOption,
            isSelected: isSelected,
            index: index,
            onTap: () => onThemeSelected(themeOption.mode),
          );
        }).toList(),
      ),
    );
  }
}

/// Widget for bottom padding to account for safe area
class _BottomPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).padding.bottom + AppDimensions.paddingMD,
    );
  }
}

/// Handles theme selection with feedback
void _handleThemeSelection(
  BuildContext context,
  ThemeMode mode,
  WidgetRef ref,
) {
  // Apply theme change
  ref.read(themeProvider.notifier).setTheme(mode);

  // Close bottom sheet with slight delay for feedback
  Future.delayed(const Duration(milliseconds: ThemeConstants.closeDelayMs), () {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  });

  // Show confirmation snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${ThemeConstants.themeChangedMessage}${ThemeOptions.getDisplayName(mode)}'),
      behavior: SnackBarBehavior.floating,
      duration: ThemeConstants.snackBarDuration,
      action: SnackBarAction(
        label: ThemeConstants.undoLabel,
        onPressed: () {
          // TODO: Implement undo functionality if needed
        },
      ),
    ),
  );
}
