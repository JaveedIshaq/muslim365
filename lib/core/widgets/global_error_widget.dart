import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/error/error.dart';
import 'package:mobile/core/error/global_error_handler.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';

/// Reusable global error widget that works for all features
class GlobalErrorWidget extends ConsumerWidget {
  final Object error;
  final VoidCallback? onRetry;
  final VoidCallback? onCustomAction;
  final String? customTitle;
  final String? customMessage;
  final String? customActionLabel;
  final Widget? customIcon;
  final bool showSupportButton;
  final bool showRefreshButton;
  final EdgeInsets? padding;

  const GlobalErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.onCustomAction,
    this.customTitle,
    this.customMessage,
    this.customActionLabel,
    this.customIcon,
    this.showSupportButton = true,
    this.showRefreshButton = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppError appError;
    if (error is AppError) {
      appError = error as AppError;
    } else {
      appError = AppError.fromException(error);
    }

    final errorInfo = GlobalErrorHandler.buildErrorInfo(
      appError,
      customTitle: customTitle,
      customMessage: customMessage,
    );

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            _buildErrorIcon(context, errorInfo, colorScheme),
            const SizedBox(height: AppDimensions.spaceLG),

            // Error Title
            Text(
              errorInfo.title,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // Error Message
            Text(
              errorInfo.message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceLG),

            // Action Buttons
            _buildActionButtons(context, errorInfo, colorScheme, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorIcon(
    BuildContext context,
    GlobalErrorInfo errorInfo,
    ColorScheme colorScheme,
  ) {
    if (customIcon != null) {
      return customIcon!;
    }

    return Container(
      width: AppDimensions.avatarXL,
      height: AppDimensions.avatarXL,
      decoration: BoxDecoration(
        color: errorInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: Icon(
        errorInfo.icon,
        size: AppDimensions.iconXL,
        color: errorInfo.color,
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    GlobalErrorInfo errorInfo,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary Action Button
        FilledButton.icon(
          onPressed: onCustomAction ?? errorInfo.onAction,
          icon: Icon(errorInfo.actionIcon, size: AppDimensions.iconMD),
          label: Text(
            customActionLabel ?? errorInfo.actionLabel,
            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: errorInfo.color,
            foregroundColor: errorInfo.color.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLG,
              vertical: AppDimensions.paddingMD,
            ),
            minimumSize: const Size(
              double.infinity,
              AppDimensions.buttonHeightLG,
            ),
          ),
        ),

        // Support Button
        if (showSupportButton && errorInfo.showSupport) ...[
          const SizedBox(height: AppDimensions.spaceSM),
          TextButton.icon(
            onPressed: () => _showSupportDialog(context),
            icon: const Icon(
              Icons.support_agent_outlined,
              size: AppDimensions.iconSM,
            ),
            label: Text(
              'Contact Support',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],

        // Retry Button (if enabled and different from primary action)
        if (showRefreshButton &&
            onRetry != null &&
            errorInfo.actionLabel != 'Retry') ...[
          const SizedBox(height: AppDimensions.spaceSM),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(
              Icons.refresh_outlined,
              size: AppDimensions.iconSM,
            ),
            label: Text(
              'Try Again',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showSupportDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Contact Support', style: textTheme.headlineSmall),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If this issue persists, please contact our support team:',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.spaceMD),
            _buildSupportOption(
              Icons.email_outlined,
              'Email Support',
              'support@nurselife.com',
              () {
                // TODO: Open email client
              },
              context,
            ),
            const SizedBox(height: AppDimensions.spaceSM),
            _buildSupportOption(
              Icons.chat_outlined,
              'Live Chat',
              'Chat with our support team',
              () {
                // TODO: Open chat
              },
              context,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Close', style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
    BuildContext context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingSM),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.primary, size: AppDimensions.iconMD),
            const SizedBox(width: AppDimensions.spaceSM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurfaceVariant,
              size: AppDimensions.iconSM,
            ),
          ],
        ),
      ),
    );
  }
}

/// Global error info class for consistent error display
class GlobalErrorInfo {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final IconData actionIcon;
  final String actionLabel;
  final VoidCallback onAction;
  final bool showSupport;

  GlobalErrorInfo({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.actionIcon,
    required this.actionLabel,
    required this.onAction,
    required this.showSupport,
  });
}
