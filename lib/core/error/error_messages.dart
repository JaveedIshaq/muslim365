import 'package:flutter/material.dart';
import 'package:mobile/core/error/error.dart';

/// Centralized error message service for global error handling
class ErrorMessages {
  /// Get user-friendly title for error code
  static String getTitle(AppErrorCode code, {String? resource}) {
    switch (code) {
      // Resource Not Found Errors
      case AppErrorCode.resourceNotFound:
        return '${_capitalize(resource ?? 'Resource')} Not Found';
      case AppErrorCode.userNotFound:
        return 'User Account Not Found';
      case AppErrorCode.profileNotFound:
        return '${_capitalize(resource ?? 'Profile')} Not Found';
      case AppErrorCode.notFound:
        return '${_capitalize(resource ?? 'Item')} Not Found';

      // Network Errors
      case AppErrorCode.noInternet:
        return 'No Internet Connection';
      case AppErrorCode.timeout:
        return 'Request Timed Out';
      case AppErrorCode.serverUnreachable:
        return 'Server Unreachable';

      // Auth Errors
      case AppErrorCode.unauthenticated:
        return 'Not Signed In';
      case AppErrorCode.unauthorized:
        return 'Access Denied';
      case AppErrorCode.permissionDenied:
        return 'Permission Denied';
      case AppErrorCode.accessDenied:
        return 'Access Denied';
      case AppErrorCode.tokenExpired:
        return 'Session Expired';

      // Database Errors
      case AppErrorCode.duplicateEntry:
        return 'Duplicate Entry';
      case AppErrorCode.constraintViolation:
        return 'Data Validation Error';
      case AppErrorCode.foreignKeyViolation:
        return 'Invalid Reference';

      // Parsing Errors
      case AppErrorCode.invalidJson:
        return 'Invalid Data Format';
      case AppErrorCode.missingRequiredField:
        return 'Required Information Missing';
      case AppErrorCode.typeMismatch:
        return 'Invalid Data Type';

      // Validation Errors
      case AppErrorCode.validationFailed:
        return 'Validation Error';
      case AppErrorCode.invalidInput:
        return 'Invalid Input';

      // Storage Errors
      case AppErrorCode.storage:
        return 'File Storage Error';
      case AppErrorCode.fileNotFound:
        return 'File Not Found';
      case AppErrorCode.uploadFailed:
        return 'File Upload Failed';
      case AppErrorCode.downloadFailed:
        return 'File Download Failed';

      // Service Errors
      case AppErrorCode.serviceUnavailable:
        return 'Service Unavailable';
      case AppErrorCode.maintenanceMode:
        return 'Service Under Maintenance';
      case AppErrorCode.quotaExceeded:
        return 'Usage Limit Exceeded';
      case AppErrorCode.rateLimited:
        return 'Too Many Requests';

      // Business Logic Errors
      case AppErrorCode.invalidRequest:
        return 'Invalid Request';
      case AppErrorCode.subscriptionExpired:
        return 'Subscription Expired';
      case AppErrorCode.accountSuspended:
        return 'Account Suspended';

      // Generic
      case AppErrorCode.unknown:
        return 'Unexpected Error';
    }
  }

  /// Get user-friendly message for error code
  static String getMessage(
    AppErrorCode code, {
    String? resource,
    String? operation,
  }) {
    switch (code) {
      // Resource Not Found Errors
      case AppErrorCode.resourceNotFound:
        return 'The ${resource ?? 'resource'} could not be found${operation != null ? ' while $operation' : ''}. Please check if the ${resource ?? 'item'} exists or try again.';
      case AppErrorCode.userNotFound:
        return 'We couldn\'t find your account${operation != null ? ' while $operation' : ''}. Please check your information or contact support.';
      case AppErrorCode.profileNotFound:
        return 'Your ${resource ?? 'profile'} hasn\'t been created yet${operation != null ? ' while $operation' : ''}. Please complete your profile to continue.';
      case AppErrorCode.notFound:
        return 'The ${resource ?? 'item'} could not be found${operation != null ? ' while $operation' : ''}. Please try again or contact support.';

      // Network Errors
      case AppErrorCode.noInternet:
        return 'Please check your internet connection and try again. Make sure Wi-Fi or mobile data is enabled.';
      case AppErrorCode.timeout:
        return 'The request took too long to complete. Please check your connection and try again.';
      case AppErrorCode.serverUnreachable:
        return 'Could not connect to our servers. This might be a temporary issue. Please try again later.';

      // Auth Errors
      case AppErrorCode.unauthenticated:
        return 'Please sign in to access this feature. Your session may have expired.';
      case AppErrorCode.unauthorized:
        return 'You don\'t have permission to access this resource. Please contact your administrator if you think this is an error.';
      case AppErrorCode.permissionDenied:
        return 'Access to this feature has been denied. Please check your account permissions.';
      case AppErrorCode.accessDenied:
        return 'You don\'t have the required permissions to perform this action.';
      case AppErrorCode.tokenExpired:
        return 'Your session has expired for security reasons. Please sign in again to continue.';

      // Database Errors
      case AppErrorCode.duplicateEntry:
        return 'This ${resource ?? 'item'} already exists. Please use a different value or check for duplicates.';
      case AppErrorCode.constraintViolation:
        return 'There was a problem with the data provided. Please review your information and try again.';
      case AppErrorCode.foreignKeyViolation:
        return 'Invalid reference detected. Please check related data and try again.';

      // Parsing Errors
      case AppErrorCode.invalidJson:
        return 'We received invalid data format. This might be a temporary issue. Please try again.';
      case AppErrorCode.missingRequiredField:
        return 'Some required information is missing. Please complete all required fields and try again.';
      case AppErrorCode.typeMismatch:
        return 'Invalid data type detected. Please check your input and try again.';

      // Validation Errors
      case AppErrorCode.validationFailed:
        return 'Please review your input and correct any errors before continuing.';
      case AppErrorCode.invalidInput:
        return 'The information provided is not valid. Please check your input and try again.';

      // Storage Errors
      case AppErrorCode.storage:
        return 'There was a problem with file storage. Please try again or contact support.';
      case AppErrorCode.fileNotFound:
        return 'The requested file could not be found. It may have been deleted or moved.';
      case AppErrorCode.uploadFailed:
        return 'Failed to upload the file. Please check your connection and try again.';
      case AppErrorCode.downloadFailed:
        return 'Failed to download the file. Please check your connection and try again.';

      // Service Errors
      case AppErrorCode.serviceUnavailable:
        return 'This service is currently unavailable. Please try again later or contact support.';
      case AppErrorCode.maintenanceMode:
        return 'The service is temporarily under maintenance. We\'ll be back soon!';
      case AppErrorCode.quotaExceeded:
        return 'You\'ve reached your usage limit. Please upgrade your plan or wait for the next billing cycle.';
      case AppErrorCode.rateLimited:
        return 'Too many requests. Please wait a moment and try again.';

      // Business Logic Errors
      case AppErrorCode.invalidRequest:
        return 'The request could not be processed. Please review your input and try again.';
      case AppErrorCode.subscriptionExpired:
        return 'Your subscription has expired. Please renew to continue using this feature.';
      case AppErrorCode.accountSuspended:
        return 'Your account has been suspended. Please contact support for assistance.';

      // Generic
      case AppErrorCode.unknown:
        return 'An unexpected error occurred. Please try again or contact support if the problem persists.';
    }
  }

  /// Get action label for error code
  static String getActionLabel(AppErrorCode code) {
    switch (code) {
      case AppErrorCode.resourceNotFound:
      case AppErrorCode.userNotFound:
      case AppErrorCode.profileNotFound:
        return 'Create Profile';
      case AppErrorCode.notFound:
        return 'Refresh';
      case AppErrorCode.noInternet:
      case AppErrorCode.timeout:
      case AppErrorCode.serverUnreachable:
        return 'Try Again';
      case AppErrorCode.unauthenticated:
      case AppErrorCode.tokenExpired:
        return 'Sign In';
      case AppErrorCode.unauthorized:
      case AppErrorCode.permissionDenied:
      case AppErrorCode.accessDenied:
        return 'Go Home';
      case AppErrorCode.duplicateEntry:
      case AppErrorCode.constraintViolation:
      case AppErrorCode.foreignKeyViolation:
        return 'Review Data';
      case AppErrorCode.invalidJson:
      case AppErrorCode.missingRequiredField:
      case AppErrorCode.typeMismatch:
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidInput:
        return 'Fix Input';
      case AppErrorCode.storage:
      case AppErrorCode.fileNotFound:
      case AppErrorCode.uploadFailed:
      case AppErrorCode.downloadFailed:
        return 'Try Again';
      case AppErrorCode.serviceUnavailable:
      case AppErrorCode.maintenanceMode:
        return 'Try Later';
      case AppErrorCode.quotaExceeded:
        return 'Upgrade Plan';
      case AppErrorCode.rateLimited:
        return 'Wait & Retry';
      case AppErrorCode.subscriptionExpired:
        return 'Renew';
      case AppErrorCode.accountSuspended:
        return 'Contact Support';
      case AppErrorCode.invalidRequest:
      case AppErrorCode.unknown:
        return 'Retry';
    }
  }

  /// Get action for error code (placeholder - to be implemented by caller)
  static VoidCallback? getAction(AppErrorCode code, {VoidCallback? onRetry}) {
    switch (code) {
      case AppErrorCode.noInternet:
      case AppErrorCode.timeout:
      case AppErrorCode.serverUnreachable:
      case AppErrorCode.storage:
      case AppErrorCode.uploadFailed:
      case AppErrorCode.downloadFailed:
      case AppErrorCode.invalidJson:
      case AppErrorCode.validationFailed:
      case AppErrorCode.notFound:
      case AppErrorCode.invalidRequest:
        return onRetry;
      default:
        return null; // Caller should implement specific action
    }
  }

  /// Determine if support should be shown for error code
  static bool shouldShowSupport(AppErrorCode code) {
    switch (code) {
      case AppErrorCode.noInternet:
      case AppErrorCode.timeout:
      case AppErrorCode.unauthenticated:
      case AppErrorCode.tokenExpired:
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidInput:
      case AppErrorCode.missingRequiredField:
      case AppErrorCode.duplicateEntry:
      case AppErrorCode.rateLimited:
        return false; // User can resolve these
      default:
        return true; // Support contact may be helpful
    }
  }

  /// Get severity level for error code
  static ErrorSeverity getSeverity(AppErrorCode code) {
    switch (code) {
      case AppErrorCode.validationFailed:
      case AppErrorCode.invalidInput:
      case AppErrorCode.missingRequiredField:
      case AppErrorCode.duplicateEntry:
      case AppErrorCode.constraintViolation:
      case AppErrorCode.foreignKeyViolation:
      case AppErrorCode.quotaExceeded:
      case AppErrorCode.rateLimited:
        return ErrorSeverity.warning; // User can potentially fix these
      case AppErrorCode.serviceUnavailable:
      case AppErrorCode.maintenanceMode:
      case AppErrorCode.accountSuspended:
      case AppErrorCode.subscriptionExpired:
        return ErrorSeverity.info; // Informational, not critical
      case AppErrorCode.unknown:
      case AppErrorCode.storage:
        return ErrorSeverity.critical; // Serious issues
      default:
        return ErrorSeverity.error; // Standard error level
    }
  }

  /// Helper method to capitalize first letter
  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
