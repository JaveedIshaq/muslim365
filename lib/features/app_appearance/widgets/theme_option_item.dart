import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';
import '../constants/theme_constants.dart';
import '../extensions/widget_animation_extensions.dart';
import '../models/theme_option.dart';

/// A widget that displays a single theme option with preview and selection state
class ThemeOptionItem extends ConsumerWidget {
  const ThemeOptionItem({
    super.key,
    required this.themeOption,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  final ThemeOption themeOption;
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
                  ? colorScheme.primary.withValues(alpha: ThemeConstants.selectedBackgroundOpacity)
                  : colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: ThemeConstants.borderOpacity),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                _ThemePreview(
                  themeOption: themeOption,
                  colorScheme: colorScheme,
                  isSelected: isSelected,
                ),
                const SizedBox(width: AppDimensions.spaceMD),
                Expanded(
                  child: _ThemeInfo(
                    themeOption: themeOption,
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

/// Widget for displaying the theme preview icon and color
class _ThemePreview extends StatelessWidget {
  const _ThemePreview({
    required this.themeOption,
    required this.colorScheme,
    required this.isSelected,
  });

  final ThemeOption themeOption;
  final ColorScheme colorScheme;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ThemeConstants.previewSize,
      height: ThemeConstants.previewSize,
      decoration: BoxDecoration(
        color: themeOption.previewColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: ThemeConstants.borderOpacity),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: ThemeConstants.shadowOpacity),
            offset: ThemeConstants.shadowOffset,
            blurRadius: ThemeConstants.shadowBlurRadius,
          ),
        ],
      ),
      child: Icon(
        themeOption.icon,
        color: themeOption.getIconColor(),
        size: AppDimensions.iconMD,
      ),
    ).animateSelection(isSelected: isSelected);
  }
}

/// Widget for displaying theme information (title and description)
class _ThemeInfo extends StatelessWidget {
  const _ThemeInfo({
    required this.themeOption,
    required this.colorScheme,
    required this.isSelected,
  });

  final ThemeOption themeOption;
  final ColorScheme colorScheme;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeOption.title,
          style: AppTypography.bodyLarge.copyWith(
            color: colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        Text(
          themeOption.description,
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
            semanticLabel: ThemeConstants.selectedLabel,
          )
        : SizedBox(
            width: AppDimensions.iconLG,
            height: AppDimensions.iconLG,
          );
  }
}