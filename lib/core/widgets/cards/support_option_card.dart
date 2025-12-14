import 'package:flutter/material.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/app_typography.dart';
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';

class SupportOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailingText;
  final Color? trailingColor;
  final VoidCallback? onTap;
  final bool isAvailable;

  const SupportOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailingText,
    this.trailingColor,
    this.onTap,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMD),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAvailable ? onTap : null,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.04),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.primary,
                    size: AppDimensions.iconLG,
                  ),
                ),

                const SizedBox(width: AppDimensions.spaceMD),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.h6.copyWith(
                          color: isAvailable
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        subtitle,
                        style: AppTypography.bodyMedium.copyWith(
                          color: isAvailable
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.onSurfaceVariant.withValues(
                                  alpha: 0.5,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing content
                if (trailingText != null) ...[
                  const SizedBox(width: AppDimensions.spaceSM),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingSM,
                          vertical: AppDimensions.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: (trailingColor ?? BrandColors.success)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSM,
                          ),
                        ),
                        child: Text(
                          trailingText!,
                          style: AppTypography.labelSmall.copyWith(
                            color: trailingColor ?? BrandColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Arrow icon
                const SizedBox(width: AppDimensions.spaceSM),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimensions.iconSM,
                  color: isAvailable
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.3,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SupportHeaderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SupportHeaderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconXL,
              color: theme.colorScheme.onPrimary,
            ),
          ),

          const SizedBox(height: AppDimensions.spaceLG),

          Text(
            title,
            style: AppTypography.h3.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.spaceSM),

          Text(
            subtitle,
            style: AppTypography.bodyLarge.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FAQQuestionTile extends StatelessWidget {
  final String question;
  final VoidCallback? onTap;

  const FAQQuestionTile({super.key, required this.question, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMD,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  question,
                  style: AppTypography.bodyLarge.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: AppDimensions.iconSM,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
