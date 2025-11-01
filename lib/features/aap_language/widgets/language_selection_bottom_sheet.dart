import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_appearance/constants/app_dimensions.dart';
import '../../app_appearance/constants/app_typography.dart';
import '../constants/language_constants.dart';
import '../../app_appearance/extensions/widget_animation_extensions.dart';
import '../models/language_model.dart';
import '../providers/language_provider.dart';
import 'language_option_item.dart';

/// Language Selection Bottom Sheet Widget
///
/// A modal bottom sheet that allows users to select between different languages.
/// Provides visual previews with flags and immediate feedback for language changes.
///
/// Usage:
/// ```dart
/// await LanguageSelectionBottomSheet.show(context);
/// ```
class LanguageSelectionBottomSheet extends ConsumerWidget {
  const LanguageSelectionBottomSheet({super.key});

  /// Shows the language selection bottom sheet
  ///
  /// Returns a Future that completes when the bottom sheet is closed.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => const LanguageSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentLanguage = ref.watch(currentLanguageProvider);

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
          _LanguageOptionsList(
            currentLanguage: currentLanguage,
            onLanguageSelected: (language) => _handleLanguageSelection(context, language, ref),
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
      width: LanguageConstants.handleWidth,
      height: LanguageConstants.handleHeight,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: LanguageConstants.handleOpacity),
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
        LanguageConstants.bottomSheetTitle,
        style: AppTypography.h5.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animateHeaderEntrance(delayMs: LanguageConstants.optionAnimationDelay);
  }
}

/// Widget for the list of language options
class _LanguageOptionsList extends StatelessWidget {
  const _LanguageOptionsList({
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  final Locale currentLanguage;
  final Function(LanguageModel) onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Column(
        children: languages.asMap().entries.map((entry) {
          final index = entry.key;
          final languageModel = entry.value;
          final isSelected = currentLanguage == languageModel.locale;

          return LanguageOptionItem(
            languageModel: languageModel,
            isSelected: isSelected,
            index: index,
            onTap: () => onLanguageSelected(languageModel),
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

/// Handles language selection with feedback
void _handleLanguageSelection(
  BuildContext context,
  LanguageModel language,
  WidgetRef ref,
) {
  // Apply language change
  ref.read(languageProvider.notifier).setLanguage(language.locale);

  // Close bottom sheet with slight delay for feedback
  Future.delayed(const Duration(milliseconds: LanguageConstants.closeDelayMs), () {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  });

  // Show confirmation snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${LanguageConstants.languageChangedMessage}${language.languageTitle}'),
      behavior: SnackBarBehavior.floating,
      duration: LanguageConstants.snackBarDuration,
      action: SnackBarAction(
        label: LanguageConstants.undoLabel,
        onPressed: () {
          // TODO: Implement undo functionality if needed
        },
      ),
    ),
  );
}
