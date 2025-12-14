import 'dart:async';
import 'dart:io';

import 'package:mobile/core/error/error.dart';
import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global error handler to centralize exception handling logic
class ErrorHandler {
  /// Handle any exception and convert it to an AppError
  static AppError handleException(
    dynamic error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? logMessage,
  }) {
    // Log the error first
    if (logMessage != null) {
      Log.error(
        logMessage,
        error: error,
        stackTrace: stackTrace,
        data: context,
      );
    }

    // If it's already an AppError, just return it (maybe with added context)
    if (error is AppError) {
      return error;
    }

    // Handle generic exceptions
    if (error is ResourceNotFoundException) {
      return AppError.notFound(
        error.resource,
        identifier: error.id,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error is DataParsingException) {
      return AppError.parsing(
        error.message,
        originalError: error.originalError,
        stackTrace: stackTrace,
        context: context,
      );
    }

    // Handle specific exception types
    // Handle Network & Connection Errors
    if (error is NetworkException ||
        error is SocketException ||
        error is TimeoutException) {
      String message = 'No internet connection. Please check your network.';
      AppErrorCode code = AppErrorCode.noInternet;
      dynamic originalError = error;

      // Unwrap NetworkException to get the real cause
      if (error is NetworkException) {
        originalError = error.originalError;
      }

      // Check specific causes
      if (originalError is TimeoutException) {
        code = AppErrorCode.timeout;
        message = 'Request timed out. Please try again.';
      }

      return AppError.network(
        message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
        context: context,
      );
    }

    if (error is PostgrestException) {
      // Map Postgres error codes
      AppErrorCode code = AppErrorCode.unknown;
      String message = 'Database error: ${error.message}';

      if (error.code == 'PGRST116') {
        code = AppErrorCode.notFound;
        message = 'Resource not found. Please contact support.';
      } else if (error.code == '23505') {
        code = AppErrorCode.duplicateEntry;
        message = 'Duplicate entry detected.';
      } else if (error.code == '23503') {
        code = AppErrorCode.foreignKeyViolation;
        message = 'Referenced data not found.';
      } else if (error.code?.startsWith('23') ?? false) {
        code = AppErrorCode.constraintViolation;
        message = 'Database constraint violation.';
      }

      return AppError.database(
        message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
        context: {...?context, 'postgresCode': error.code},
      );
    }

    if (error is AuthException) {
      AppErrorCode code = AppErrorCode.unauthenticated;
      if (error.statusCode == '403') {
        code = AppErrorCode.unauthorized;
      } else if (error.message.toLowerCase().contains('token')) {
        code = AppErrorCode.tokenExpired;
      }

      return AppError.auth(
        'Authentication error. Please sign in again.',
        code: code,
        originalError: error,
        stackTrace: stackTrace,
        context: context,
      );
    }

    if (error is StorageException) {
      return AppError.storage(
        'Storage error: ${error.message}',
        code: AppErrorCode.storage,
        originalError: error,
        stackTrace: stackTrace,
        context: context,
      );
    }

    // Fallback for unknown errors
    return AppError.unknown(
      'An unexpected error occurred. Please try again.',
      originalError: error,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Global stream error handler for use with .handleError()
  ///
  /// Usage: `.handleError(ErrorHandler.handleStreamError)`
  ///
  /// This method catches stream errors, converts them to AppError,
  /// logs them, and rethrows for Riverpod to catch.
  static void handleStreamError(Object error, StackTrace stackTrace) {
    // Convert to AppError and log
    final appError = handleException(
      error,
      stackTrace: stackTrace,
      context: {'source': 'stream'},
      logMessage: 'Stream error caught',
    );

    // Rethrow so Riverpod can catch it
    throw appError;
  }
}
