import 'package:flutter/material.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/app_typography.dart';
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';

enum AppButtonSize { small, medium, large }

/// Simple, clean, and easy-to-understand custom button component
class AppCustomButton extends StatelessWidget {
  // Core properties
  final String text;
  final VoidCallback? onPressed;
  final AppButtonSize size;

  // State properties
  final bool isLoading;
  final bool isEnabled;

  // Visual properties
  final Widget? icon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppCustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.padding,
  });

  // Get button height based on size
  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeightSM;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeightMD;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLG;
    }
  }

  // Get text style based on size
  TextStyle get _textStyle {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.buttonSmall;
      case AppButtonSize.medium:
        return AppTypography.buttonMedium;
      case AppButtonSize.large:
        return AppTypography.buttonLarge;
    }
  }

  // Determine if button should be disabled
  bool get _isDisabled => !isEnabled || isLoading || onPressed == null;

  // Get appropriate colors based on button state
  Color _getTextColor(BuildContext context) {
    return _isDisabled
        ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38)
        : Theme.of(context).colorScheme.onPrimary;
  }

  Color _getLoadingColor(BuildContext context) {
    return _isDisabled
        ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38)
        : Theme.of(context).colorScheme.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: _height,
      decoration: _buildDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
            child: _buildButtonContent(context),
          ),
        ),
      ),
    );
  }

  // Build container decoration
  BoxDecoration _buildDecoration(BuildContext context) {
    if (_isDisabled) {
      return BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
      );
    }

    return BoxDecoration(
      gradient: BrandColors.primaryGradient,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
      ],
    );
  }

  // Build button content (icon + text or loading indicator)
  Widget _buildButtonContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Show loading spinner or icon
        if (isLoading) ...[
          _buildLoadingIndicator(context),
          const SizedBox(width: AppDimensions.spaceSM),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: AppDimensions.spaceSM),
        ],

        // Button text
        Flexible(
          child: Text(
            text,
            style: _textStyle.copyWith(color: _getTextColor(context)),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Build loading indicator
  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_getLoadingColor(context)),
      ),
    );
  }
}
