import 'package:flutter/material.dart';
import 'package:mobile/core/error/error.dart';
import 'package:mobile/core/error/error_messages.dart';
import 'package:mobile/core/widgets/global_error_widget.dart';

/// Global error handler for context-aware error handling across all features
class GlobalErrorHandler {
  /// Build error info with context awareness
  static GlobalErrorInfo buildErrorInfo(
    AppError error, {
    String? resource,
    String? operation,
    String? customTitle,
    String? customMessage,
    String? customActionLabel,
    VoidCallback? customAction,
    VoidCallback? onRetry,
  }) {
    return GlobalErrorInfo(
      icon: _getIcon(error.code),
      color: _getColor(error.code),
      title:
          customTitle ?? ErrorMessages.getTitle(error.code, resource: resource),
      message:
          customMessage ??
          error.userMessage ??
          ErrorMessages.getMessage(
            error.code,
            resource: resource,
            operation: operation,
          ),
      actionIcon: _getActionIcon(error.code),
      actionLabel:
          customActionLabel ?? ErrorMessages.getActionLabel(error.code),
      onAction: customAction ?? _buildAction(error, onRetry: onRetry),
      showSupport: ErrorMessages.shouldShowSupport(error.code),
    );
  }

  /// Build error info for general (non-AppError) errors
  static GlobalErrorInfo buildGenericErrorInfo(
    Object error, {
    VoidCallback? onRetry,
    String? customMessage,
  }) {
    return GlobalErrorInfo(
      icon: Icons.error_outline,
      color: Colors.red,
      title: 'Unexpected Error',
      message:
          customMessage ??
          'An unexpected error occurred. Please try again or contact support.',
      actionIcon: Icons.refresh,
      actionLabel: 'Retry',
      onAction: onRetry ?? () {},
      showSupport: true,
    );
  }

  /// Handle error with navigation and actions
  static void handleError(
    AppError error, {
    BuildContext? context,
    String? resource,
    String? operation,
    VoidCallback? onRetry,
    VoidCallback? onAuthRequired,
    VoidCallback? onPermissionDenied,
    VoidCallback? onResourceNotFound,
    VoidCallback? onSubscriptionExpired,
    VoidCallback? onAccountSuspended,
  }) {
    switch (error.code) {
      case AppErrorCode.unauthenticated:
      case AppErrorCode.tokenExpired:
        onAuthRequired?.call();
        break;

      case AppErrorCode.unauthorized:
      case AppErrorCode.permissionDenied:
      case AppErrorCode.accessDenied:
        onPermissionDenied?.call();
        break;

      case AppErrorCode.resourceNotFound:
      case AppErrorCode.userNotFound:
      case AppErrorCode.profileNotFound:
        onResourceNotFound?.call();
        break;

      case AppErrorCode.subscriptionExpired:
        onSubscriptionExpired?.call();
        break;

      case AppErrorCode.accountSuspended:
        onAccountSuspended?.call();
        break;

      default:
        // Use default retry action
        break;
    }
  }

  /// Convert any error to AppError if needed
  static AppError toAppError(Object error, [StackTrace? stackTrace]) {
    return error is AppError
        ? error
        : AppError.fromException(error, stackTrace);
  }

  /// Get appropriate icon for error code
  static IconData _getIcon(AppErrorCode code) {
    switch (code) {
      // Resource Not Found Errors
      case AppErrorCode.resourceNotFound:
      case AppErrorCode.userNotFound:
      case AppErrorCode.profileNotFound:
      case AppErrorCode.notFound:
        return Icons.search_off;

      // Network Errors
      case AppErrorCode.noInternet:
        return Icons.wifi_off;
      case AppErrorCode.timeout:
        return Icons.access_time;
      case AppErrorCode.serverUnreachable:
        return Icons.cloud_off;

      // Auth Errors
      case AppErrorCode.unauthenticated:
      case AppErrorCode.tokenExpired:
        return Icons.lock_outline;
      case AppErrorCode.unauthorized:
      case AppErrorCode.permissionDenied:
      case AppErrorCode.accessDenied:
        return Icons.block;

      // Database Errors
      case AppErrorCode.duplicateEntry:
        return Icons.content_copy;
      case AppErrorCode.constraintViolation:
      case AppErrorCode.foreignKeyViolation:
        return Icons.error_outline;

      // Parsing Errors
      case AppErrorCode.invalidJson:
      case AppErrorCode.missingRequiredField:
      case AppErrorCode.typeMismatch:
        return Icons.warning;

      // Validation Errors
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidInput:
        return Icons.rule;

      // Storage Errors
      case AppErrorCode.storage:
      case AppErrorCode.fileNotFound:
      case AppErrorCode.uploadFailed:
      case AppErrorCode.downloadFailed:
        return Icons.folder_off;

      // Service Errors
      case AppErrorCode.serviceUnavailable:
      case AppErrorCode.maintenanceMode:
        return Icons.build;
      case AppErrorCode.quotaExceeded:
        return Icons.data_usage;
      case AppErrorCode.rateLimited:
        return Icons.speed;

      // Business Logic Errors
      case AppErrorCode.invalidRequest:
        return Icons.report_problem;
      case AppErrorCode.subscriptionExpired:
        return Icons.card_membership;
      case AppErrorCode.accountSuspended:
        return Icons.person_off;

      // Generic
      case AppErrorCode.unknown:
        return Icons.help_outline;
    }
  }

  /// Get appropriate color for error code
  static Color _getColor(AppErrorCode code) {
    final severity = ErrorMessages.getSeverity(code);

    switch (severity) {
      case ErrorSeverity.info:
        return Colors.blue;
      case ErrorSeverity.warning:
        return Colors.orange;
      case ErrorSeverity.error:
        return Colors.red;
      case ErrorSeverity.critical:
        return Colors.red.shade700;
    }
  }

  /// Get action icon for error code
  static IconData _getActionIcon(AppErrorCode code) {
    switch (code) {
      case AppErrorCode.resourceNotFound:
      case AppErrorCode.userNotFound:
      case AppErrorCode.profileNotFound:
        return Icons.add_circle_outline;
      case AppErrorCode.noInternet:
      case AppErrorCode.timeout:
      case AppErrorCode.serverUnreachable:
      case AppErrorCode.notFound:
        return Icons.refresh;
      case AppErrorCode.unauthenticated:
      case AppErrorCode.tokenExpired:
        return Icons.login;
      case AppErrorCode.unauthorized:
      case AppErrorCode.permissionDenied:
      case AppErrorCode.accessDenied:
        return Icons.home;
      case AppErrorCode.duplicateEntry:
      case AppErrorCode.constraintViolation:
      case AppErrorCode.foreignKeyViolation:
        return Icons.edit;
      case AppErrorCode.invalidJson:
      case AppErrorCode.missingRequiredField:
      case AppErrorCode.typeMismatch:
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidInput:
        return Icons.edit;
      case AppErrorCode.storage:
      case AppErrorCode.uploadFailed:
      case AppErrorCode.downloadFailed:
        return Icons.refresh;
      case AppErrorCode.serviceUnavailable:
      case AppErrorCode.maintenanceMode:
        return Icons.schedule;
      case AppErrorCode.quotaExceeded:
      case AppErrorCode.subscriptionExpired:
        return Icons.upgrade;
      case AppErrorCode.rateLimited:
        return Icons.hourglass_empty;
      case AppErrorCode.accountSuspended:
        return Icons.support_agent;
      case AppErrorCode.invalidRequest:
      case AppErrorCode.unknown:
      default:
        return Icons.refresh;
    }
  }

  /// Build appropriate action for error code
  static VoidCallback _buildAction(AppError error, {VoidCallback? onRetry}) {
    final defaultAction = onRetry ?? () {};

    // For errors that have retry functionality
    switch (error.code) {
      case AppErrorCode.noInternet:
      case AppErrorCode.timeout:
      case AppErrorCode.serverUnreachable:
      case AppErrorCode.notFound:
      case AppErrorCode.storage:
      case AppErrorCode.uploadFailed:
      case AppErrorCode.downloadFailed:
      case AppErrorCode.invalidJson:
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidRequest:
        return defaultAction;
      default:
        // For other errors, return default action but caller should implement specific action
        return defaultAction;
    }
  }

  /// Create SnackBar for error notification
  static SnackBar createSnackBar(
    AppError error, {
    VoidCallback? action,
    Duration? duration,
  }) {
    final color = _getColor(error.code);
    final label = ErrorMessages.getActionLabel(error.code);

    return SnackBar(
      content: Row(
        children: [
          Icon(_getIcon(error.code), color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error.userMessage ?? ErrorMessages.getMessage(error.code),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: color,
      action: action != null
          ? SnackBarAction(
              label: label,
              textColor: Colors.white,
              onPressed: action,
            )
          : null,
      duration: duration ?? const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
    );
  }

  /// Show error dialog
  static Future<void> showErrorDialog(
    BuildContext context,
    AppError error, {
    String? title,
    VoidCallback? onRetry,
    bool showSupport = true,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          _getIcon(error.code),
          color: _getColor(error.code),
          size: 32,
        ),
        title: Text(title ?? ErrorMessages.getTitle(error.code)),
        content: Text(
          error.userMessage ?? ErrorMessages.getMessage(error.code),
        ),
        actions: [
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: Text(ErrorMessages.getActionLabel(error.code)),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          if (showSupport)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to support
              },
              child: const Text('Contact Support'),
            ),
        ],
      ),
    );
  }
}
