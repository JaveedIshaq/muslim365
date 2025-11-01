import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_appearance/constants/app_dimensions.dart';
import '../../app_appearance/constants/app_typography.dart';
import '../constants/language_constants.dart';
import '../../app_appearance/extensions/widget_animation_extensions.dart';
import '../models/language_model.dart';

/// A widget that displays a single language option with flag and selection state
class LanguageOptionItem extends ConsumerWidget {
  const LanguageOptionItem({
    super.key,
    required this.languageModel,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  final LanguageModel languageModel;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMD),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMD),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: LanguageConstants.selectedBackgroundOpacity)
                  : colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: LanguageConstants.borderOpacity),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                _LanguageFlag(
                  languageModel: languageModel,
                  colorScheme: colorScheme,
                  isSelected: isSelected,
                ),
                const SizedBox(width: AppDimensions.spaceMD),
                Expanded(
                  child: _LanguageInfo(
                    languageModel: languageModel,
                    colorScheme: colorScheme,
                    isSelected: isSelected,
                  ),
                ),
                _SelectionIndicator(
                  isSelected: isSelected,
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateListItemEntrance(index: index);
  }
}

/// Widget for displaying the language flag
class _LanguageFlag extends StatelessWidget {
  const _LanguageFlag({
    required this.languageModel,
    required this.colorScheme,
    required this.isSelected,
  });

  final LanguageModel languageModel;
  final ColorScheme colorScheme;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: LanguageConstants.flagSize,
      height: LanguageConstants.flagSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: LanguageConstants.borderOpacity),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: LanguageConstants.shadowOpacity),
            offset: LanguageConstants.shadowOffset,
            blurRadius: LanguageConstants.shadowBlurRadius,
          ),
        ],
      ),
      child: Center(
        child: Text(
          languageModel.flag,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    ).animateSelection(isSelected: isSelected);
  }
}

/// Widget for displaying language information
class _LanguageInfo extends StatelessWidget {
  const _LanguageInfo({
    required this.languageModel,
    required this.colorScheme,
    required this.isSelected,
  });

  final LanguageModel languageModel;
  final ColorScheme colorScheme;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageModel.languageTitle,
          style: AppTypography.bodyLarge.copyWith(
            color: colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        Text(
          '${languageModel.languageCode}-${languageModel.countryCode}',
          style: AppTypography.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Widget for displaying the selection indicator
class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({
    required this.isSelected,
    required this.colorScheme,
  });

  final bool isSelected;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Icon(
            Icons.check_circle,
            color: colorScheme.primary,
            size: AppDimensions.iconLG,
            semanticLabel: LanguageConstants.selectedLabel,
          )
        : SizedBox(
            width: AppDimensions.iconLG,
            height: AppDimensions.iconLG,
          );
  }
}