import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Error type categorization
enum ErrorType {
  auth, // Authentication and authorization errors
  database, // Database or storage errors
  storage, // Storage (Supabase Storage) errors
  parsing, // JSON parsing errors
  network, // Network connection issues
  validation, // Input validation errors
  business, // Business logic errors
  permission, // Authorization/permission errors
  unknown, // Unknown or unspecified errors
}

/// Specific error codes for precise error handling
enum AppErrorCode {
  /// Resource not found errors
  notFound,
  resourceNotFound, // Generic - can apply to nurses, hospitals, agencies, etc.
  userNotFound, // More specific to user/account operations
  profileNotFound, // For profile-related operations
  /// Network errors
  noInternet,
  timeout,
  serverUnreachable,

  /// Auth errors
  unauthenticated,
  unauthorized,
  tokenExpired,

  /// Database errors
  constraintViolation,
  duplicateEntry,
  foreignKeyViolation,

  /// Parsing errors
  invalidJson,
  missingRequiredField,
  typeMismatch,

  /// Storage errors
  storage,
  fileNotFound,
  uploadFailed,
  downloadFailed,

  /// Validation errors
  validationFailed,
  invalidInput,

  /// Permission errors
  permissionDenied,
  accessDenied,

  /// Service errors
  serviceUnavailable,
  maintenanceMode,
  quotaExceeded,
  rateLimited,

  /// Business logic errors
  invalidRequest,
  subscriptionExpired,
  accountSuspended,

  /// Generic
  unknown,
}

/// Error severity levels for prioritization and user experience
enum ErrorSeverity {
  info, // Informational messages, not critical
  warning, // Warning messages, user should be aware
  error, // Error conditions that affect functionality
  critical, // Critical errors that require immediate attention
}

/// Structured error context for better debugging and error tracking
class ErrorContext {
  /// Resource type (e.g., 'nurse', 'hospital', 'agency')
  final String? resource;

  /// Operation being performed (e.g., 'create', 'update', 'delete')
  final String? operation;

  /// User ID involved in the error
  final String? userId;

  /// Resource ID if applicable
  final String? resourceId;

  /// Additional context data
  final Map<String, dynamic> additionalData;

  const ErrorContext({
    this.resource,
    this.operation,
    this.userId,
    this.resourceId,
    this.additionalData = const {},
  });

  /// Convert to Map for compatibility with existing AppError.context
  Map<String, dynamic> toMap() {
    return {
      if (resource != null) 'resource': resource,
      if (operation != null) 'operation': operation,
      if (userId != null) 'userId': userId,
      if (resourceId != null) 'resourceId': resourceId,
      ...additionalData,
    };
  }

  @override
  String toString() {
    final parts = <String>[];
    if (resource != null) parts.add('resource: $resource');
    if (operation != null) parts.add('operation: $operation');
    if (userId != null) parts.add('userId: $userId');
    if (resourceId != null) parts.add('resourceId: $resourceId');
    if (additionalData.isNotEmpty) parts.add('additional: $additionalData');
    return parts.join(', ');
  }
}

/// Enhanced error model with error codes and context
class AppError extends Equatable {
  /// Error category/type
  final ErrorType type;

  /// Specific error code for precise handling
  final AppErrorCode code;

  /// Technical error message (for developers/logs)
  final String message;

  /// User-friendly error message (for UI display)
  final String? userMessage;

  /// Error severity level
  final ErrorSeverity severity;

  /// Original error that was caught
  final dynamic originalError;

  /// Stack trace for better debugging
  final StackTrace? stackTrace;

  /// Additional context (resource, operation, etc.)
  final Map<String, dynamic>? context;

  /// Standard constructor
  const AppError(
    this.type,
    this.message, {
    this.code = AppErrorCode.unknown,
    this.userMessage,
    this.severity = ErrorSeverity.error,
    this.originalError,
    this.stackTrace,
    this.context,
  });

  /// Factory method to create an AppError from an exception
  static AppError fromException(
    dynamic e, [
    StackTrace? st,
    Map<String, dynamic>? context,
  ]) {
    ErrorType type = ErrorType.unknown;
    AppErrorCode code = AppErrorCode.unknown;
    String message = e.toString();

    // Network exceptions
    if (e is SocketException) {
      type = ErrorType.network;
      code = AppErrorCode.noInternet;
      message = 'No internet connection. Please check your network.';
    } else if (e is TimeoutException) {
      type = ErrorType.network;
      code = AppErrorCode.timeout;
      message = 'Request timed out. Please try again.';
    } else if (e is HttpException) {
      type = ErrorType.network;
      code = AppErrorCode.serverUnreachable;
      message = 'Server is unreachable. Please try again later.';
    }
    // Auth exceptions
    else if (e is supabase.AuthException) {
      type = ErrorType.auth;
      message = e.message;

      if (e.statusCode == '401') {
        code = AppErrorCode.unauthenticated;
      } else if (e.statusCode == '403') {
        code = AppErrorCode.unauthorized;
      } else if (e.message.toLowerCase().contains('token')) {
        code = AppErrorCode.tokenExpired;
      }
    }
    // Database exceptions
    else if (e is supabase.PostgrestException) {
      type = ErrorType.database;
      message = e.message;

      if (e.code == 'PGRST116') {
        code = AppErrorCode.notFound;
      } else if (e.code == '23505') {
        code = AppErrorCode.duplicateEntry;
      } else if (e.code == '23503') {
        code = AppErrorCode.foreignKeyViolation;
      } else if (e.code?.startsWith('23') ?? false) {
        code = AppErrorCode.constraintViolation;
      }
    }
    // String/message-based detection (fallback)
    else if (e.toString().toLowerCase().contains('network')) {
      type = ErrorType.network;
      code = AppErrorCode.noInternet;
    } else if (e.toString().toLowerCase().contains('parsing') ||
        e.toString().contains('JSON')) {
      type = ErrorType.parsing;
      code = AppErrorCode.invalidJson;
    }
    // Validation errors
    else if (e.toString().toLowerCase().contains('validation') ||
        e.toString().toLowerCase().contains('invalid') ||
        e.toString().toLowerCase().contains('required')) {
      type = ErrorType.validation;
      code = AppErrorCode.validationFailed;
      if (e.toString().toLowerCase().contains('required')) {
        code = AppErrorCode.missingRequiredField;
      } else if (e.toString().toLowerCase().contains('input')) {
        code = AppErrorCode.invalidInput;
      }
    }
    // Permission errors
    else if (e.toString().toLowerCase().contains('permission') ||
        e.toString().toLowerCase().contains('forbidden') ||
        e.toString().toLowerCase().contains('denied')) {
      type = ErrorType.permission;
      code = AppErrorCode.permissionDenied;
      if (e.toString().toLowerCase().contains('access')) {
        code = AppErrorCode.accessDenied;
      }
    }
    // Service errors
    else if (e.toString().toLowerCase().contains('maintenance') ||
        e.toString().toLowerCase().contains('unavailable') ||
        e.toString().toLowerCase().contains('quota') ||
        e.toString().toLowerCase().contains('rate limit')) {
      type = ErrorType.network;
      if (e.toString().toLowerCase().contains('maintenance')) {
        code = AppErrorCode.maintenanceMode;
      } else if (e.toString().toLowerCase().contains('unavailable')) {
        code = AppErrorCode.serviceUnavailable;
      } else if (e.toString().toLowerCase().contains('quota')) {
        code = AppErrorCode.quotaExceeded;
      } else if (e.toString().toLowerCase().contains('rate limit')) {
        code = AppErrorCode.rateLimited;
      }
    }

    // Determine severity and user message based on error type
    ErrorSeverity severity = ErrorSeverity.error;
    String? userMessage = message; // Default user message to technical message

    switch (type) {
      case ErrorType.validation:
        severity = ErrorSeverity.warning;
        userMessage = 'Please check your input and try again';
        break;
      case ErrorType.auth:
        severity = ErrorSeverity.error;
        if (code == AppErrorCode.unauthenticated) {
          userMessage = 'Please log in to continue';
        } else if (code == AppErrorCode.permissionDenied) {
          userMessage = 'You don\'t have permission to perform this action';
        }
        break;
      case ErrorType.network:
        severity = ErrorSeverity.error;
        if (code == AppErrorCode.noInternet) {
          userMessage = 'No internet connection. Please check your network';
        } else if (code == AppErrorCode.timeout) {
          userMessage = 'Request timed out. Please try again';
        }
        break;
      case ErrorType.database:
        severity = ErrorSeverity.error;
        userMessage = 'An error occurred while accessing the database';
        break;
      case ErrorType.storage:
        severity = ErrorSeverity.error;
        userMessage = 'An error occurred while accessing file storage';
        break;
      case ErrorType.parsing:
        severity = ErrorSeverity.error;
        userMessage = 'Invalid data format received';
        break;
      case ErrorType.permission:
        severity = ErrorSeverity.warning;
        userMessage = 'Permission denied. Please check your access rights';
        break;
      case ErrorType.business:
        severity = ErrorSeverity.warning;
        userMessage = 'Unable to complete this request';
        break;
      case ErrorType.unknown:
        severity = ErrorSeverity.error;
        userMessage = 'An unexpected error occurred';
        break;
    }

    return AppError(
      type,
      message,
      code: code,
      userMessage: userMessage,
      severity: severity,
      originalError: e,
      stackTrace: st,
      context: context,
    );
  }

  /// Create an auth error
  factory AppError.auth(
    String message, {
    AppErrorCode code = AppErrorCode.unauthenticated,
    String? userMessage,
    ErrorSeverity severity = ErrorSeverity.error,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.auth,
      message,
      code: code,
      userMessage: userMessage,
      severity: severity,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a network error
  factory AppError.network(
    String message, {
    AppErrorCode code = AppErrorCode.noInternet,
    String? userMessage,
    ErrorSeverity severity = ErrorSeverity.error,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.network,
      message,
      code: code,
      userMessage: userMessage,
      severity: severity,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a database error
  factory AppError.database(
    String message, {
    AppErrorCode code = AppErrorCode.unknown,
    String? userMessage,
    ErrorSeverity severity = ErrorSeverity.error,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.database,
      message,
      code: code,
      userMessage:
          userMessage ?? 'A database error occurred. Please try again.',
      severity: severity,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a parsing error
  factory AppError.parsing(
    String message, {
    AppErrorCode code = AppErrorCode.invalidJson,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.parsing,
      message,
      code: code,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a storage error
  factory AppError.storage(
    String message, {
    AppErrorCode code = AppErrorCode.storage,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.storage,
      message,
      code: code,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create an unknown error
  factory AppError.unknown(
    String message, {
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError(
      ErrorType.unknown,
      message,
      code: AppErrorCode.unknown,
      originalError: originalError,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a "not found" error (legacy - use resourceNotFound instead)
  factory AppError.notFound(
    String resource, {
    String? identifier,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.database,
      '$resource not found${identifier != null ? ': $identifier' : ''}',
      code: AppErrorCode.notFound,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        'resource': resource,
        if (identifier != null) 'identifier': identifier,
      },
    );
  }

  /// Create a "resource not found" error (global replacement for nurseNotFound)
  factory AppError.resourceNotFound(
    String resource, {
    String? id,
    String? operation,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.database,
      '$resource not found${id != null ? ' (ID: $id)' : ''}',
      code: AppErrorCode.resourceNotFound,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        'resource': resource,
        if (id != null) 'id': id,
        if (operation != null) 'operation': operation,
      },
    );
  }

  /// Create a "user not found" error
  factory AppError.userNotFound({
    String? userId,
    String? operation,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.database,
      'User not found${userId != null ? ' (ID: $userId)' : ''}',
      code: AppErrorCode.userNotFound,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        if (userId != null) 'userId': userId,
        if (operation != null) 'operation': operation,
      },
    );
  }

  /// Create a "profile not found" error
  factory AppError.profileNotFound({
    String? profileId,
    String? profileType,
    String? operation,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.database,
      '${profileType != null ? '$profileType profile' : 'Profile'} not found${profileId != null ? ' (ID: $profileId)' : ''}',
      code: AppErrorCode.profileNotFound,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        if (profileId != null) 'profileId': profileId,
        if (profileType != null) 'profileType': profileType,
        if (operation != null) 'operation': operation,
      },
    );
  }

  /// Create a validation error
  factory AppError.validation(
    String message, {
    AppErrorCode code = AppErrorCode.validationFailed,
    String? field,
    dynamic value,
    dynamic originalError,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalContext,
  }) {
    return AppError(
      ErrorType.validation,
      message,
      code: code,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        if (field != null) 'field': field,
        if (value != null) 'value': value,
        ...?additionalContext,
      },
    );
  }

  /// Create a permission error
  factory AppError.permission(
    String message, {
    AppErrorCode code = AppErrorCode.permissionDenied,
    String? resource,
    String? action,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.auth,
      message,
      code: code,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        if (resource != null) 'resource': resource,
        if (action != null) 'action': action,
      },
    );
  }

  /// Create a service unavailable error
  factory AppError.serviceUnavailable({
    String? service,
    String? reason,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      ErrorType.network,
      '${service != null ? '$service service' : 'Service'} unavailable${reason != null ? ': $reason' : ''}',
      code: AppErrorCode.serviceUnavailable,
      originalError: originalError,
      stackTrace: stackTrace,
      context: {
        if (service != null) 'service': service,
        if (reason != null) 'reason': reason,
      },
    );
  }

  @override
  List<Object?> get props => [
    type,
    code,
    message,
    userMessage,
    severity,
    originalError,
    stackTrace,
    context,
  ];

  @override
  String toString() {
    final buffer = StringBuffer('AppError($type, $severity, $code): $message');
    if (userMessage != null && userMessage != message) {
      buffer.write('\n  User Message: $userMessage');
    }
    if (context != null && context!.isNotEmpty) {
      buffer.write('\n  Context: $context');
    }
    if (stackTrace != null) {
      buffer.write('\n  StackTrace: $stackTrace');
    }
    return buffer.toString();
  }
}

// Backward compatibility
typedef Failure = AppError;
