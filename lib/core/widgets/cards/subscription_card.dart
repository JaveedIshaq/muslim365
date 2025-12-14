import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/app_typography.dart';
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';
import '../buttons/app_custom_button.dart';

/// Subscription Card Widget
///
/// A reusable card component for displaying subscription plan information
/// with premium styling and customizable actions.
class SubscriptionCard extends StatelessWidget {
  final String planId;
  final String planName;
  final String price;
  final String billingPeriod;
  final List<String> features;
  final bool isActive;
  final bool isPro;
  final DateTime? renewalDate;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool showFeatures;
  final int maxFeatures;

  const SubscriptionCard({
    super.key,
    required this.planId,
    required this.planName,
    required this.price,
    required this.billingPeriod,
    required this.features,
    this.isActive = false,
    this.isPro = false,
    this.renewalDate,
    this.buttonText = 'Manage',
    this.onButtonPressed,
    this.showFeatures = true,
    this.maxFeatures = 3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          decoration: BoxDecoration(
            gradient: isPro ? BrandColors.primaryGradient : null,
            color: isPro ? null : colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
            border: Border.all(
              color: isPro
                  ? Colors.transparent
                  : colorScheme.outline.withValues(alpha: 0.2),
            ),
            boxShadow: isPro
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with badges
              _buildHeader(colorScheme),

              const SizedBox(height: AppDimensions.spaceMD),

              // Plan name and pricing
              _buildPlanInfo(colorScheme),

              // Renewal date
              if (renewalDate != null) _buildRenewalInfo(colorScheme),

              // Features list
              if (showFeatures && features.isNotEmpty)
                _buildFeatures(colorScheme),

              const SizedBox(height: AppDimensions.spaceLG),

              // Action button
              _buildActionButton(colorScheme),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideY(begin: 0.3, end: 0.0, duration: 400.ms);
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Pro badge
        if (isPro)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSM,
              vertical: AppDimensions.paddingXS,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
            ),
            child: Text(
              'PRO',
              style: AppTypography.labelSmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          const SizedBox(),

        // Status indicator
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSM,
            vertical: AppDimensions.paddingXS,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? BrandColors.success.withValues(alpha: 0.2)
                : colorScheme.error.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
          ),
          child: Text(
            isActive ? 'Active' : 'Inactive',
            style: AppTypography.labelSmall.copyWith(
              color: isActive ? BrandColors.success : colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanInfo(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          planName,
          style: AppTypography.h5.copyWith(
            color: isPro ? Colors.white : colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: AppDimensions.spaceXS),

        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              price,
              style: AppTypography.h4.copyWith(
                color: isPro ? Colors.white : colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '/$billingPeriod',
              style: AppTypography.bodyMedium.copyWith(
                color: isPro
                    ? Colors.white.withValues(alpha: 0.8)
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRenewalInfo(ColorScheme colorScheme) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSM),
        Text(
          'Renews on ${_formatDate(renewalDate!)}',
          style: AppTypography.bodySmall.copyWith(
            color: isPro
                ? Colors.white.withValues(alpha: 0.8)
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(ColorScheme colorScheme) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLG),
        ...features
            .take(maxFeatures)
            .map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceXS),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: AppDimensions.iconSM,
                      color: isPro ? Colors.white : BrandColors.success,
                    ),
                    const SizedBox(width: AppDimensions.spaceSM),
                    Expanded(
                      child: Text(
                        feature,
                        style: AppTypography.bodySmall.copyWith(
                          color: isPro
                              ? Colors.white.withValues(alpha: 0.9)
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildActionButton(ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      child: isPro
          ? AppCustomButton(
              text: buttonText,
              onPressed: onButtonPressed,
              size: AppButtonSize.medium,
            )
          : OutlinedButton(
              onPressed: onButtonPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.primary,
                side: BorderSide(color: colorScheme.primary),
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingMD,
                ),
              ),
              child: Text(buttonText),
            ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
