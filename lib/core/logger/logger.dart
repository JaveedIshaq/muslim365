// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile/core/services/app_logger.dart';

/// Unified logging system for the application
/// Handles both general logs and Supabase-specific logs
class Log {
  static final Log _instance = Log._internal();
  static Log get instance => _instance;

  Log._internal()
    : _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.none,
        ),
      );

  final Logger _logger;

  /// Get the AppLogger instance for file logging
  AppLogger get _fileLogger => AppLogger.instance;

  // Log levels for Supabase logging
  static const LogLevel supabaseLogLevel = LogLevel.BODY;

  /// Configure error handlers for Flutter and Crashlytics
  static void configureLogger() {
    FlutterError.onError = (errorDetails) {
      error(
        'Flutter Error',
        error: errorDetails.exception,
        stackTrace: errorDetails.stack,
      );
      // FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      Log.error('Uncaught Error', error: error, stackTrace: stack);
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // ==================== GENERAL LOGGING ====================

  /// Log trace/verbose messages (lowest priority)
  static void trace(String message, {dynamic data}) {
    if (!kDebugMode) return;
    _instance._logger.t(_formatMessage('🔍', message, data));
    _instance._fileLogger.debug(
      message,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log debug messages for development
  static void debug(String message, {dynamic data}) {
    if (!kDebugMode) return;
    _instance._logger.d(_formatMessage('🐛', message, data));
    _instance._fileLogger.debug(
      message,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log informational messages
  static void info(String message, {dynamic data}) {
    if (!kDebugMode) return;
    _instance._logger.i(_formatMessage('ℹ️', message, data));
    _instance._fileLogger.info(
      message,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log success messages
  static void success(String message, {dynamic data}) {
    if (!kDebugMode) return;
    _instance._logger.i(_formatMessage('✅', message, data));
    _instance._fileLogger.info(
      message,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log warning messages
  static void warning(String message, {dynamic data}) {
    if (!kDebugMode) return;
    _instance._logger.w(_formatMessage('⚠️', message, data));
    _instance._fileLogger.warning(
      message,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log error messages
  static void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    dynamic data,
  }) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.write(_formatMessage('❌', message, data));

    if (error != null) {
      buffer.write('\n   Error: $error');
    }

    _instance._logger.e(
      buffer.toString(),
      error: error,
      stackTrace: stackTrace,
    );

    // Also log to file
    _instance._fileLogger.error(
      message,
      error: error,
      stackTrace: stackTrace,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  /// Log fatal/critical errors
  static void fatal(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    dynamic data,
  }) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.write(_formatMessage('🔥', message, data));

    if (error != null) {
      buffer.write('\n   Error: $error');
    }

    _instance._logger.f(
      buffer.toString(),
      error: error,
      stackTrace: stackTrace,
    );

    // Also log to file
    _instance._fileLogger.fatal(
      message,
      error: error,
      stackTrace: stackTrace,
      context: data is Map<String, dynamic> ? data : null,
    );
  }

  // ==================== SUPABASE LOGGING ====================

  /// Log a Supabase request
  static void supabaseRequest(
    String method,
    String path, {
    Map<String, dynamic>? data,
  }) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.write('\n🔷 Supabase Request\n');
    buffer.write('➡️  $method $path\n');

    if (supabaseLogLevel == LogLevel.HEADERS ||
        supabaseLogLevel == LogLevel.BODY) {
      final headers = _getSupabaseHeaders();
      buffer.write('📋 Headers:\n${_stringifyHeaders(headers)}\n');
    }

    if (supabaseLogLevel == LogLevel.BODY && data != null) {
      buffer.write('📦 Body:\n${_prettyJson(data)}\n');
    }

    _instance._logger.i(buffer.toString());
  }

  /// Log a Supabase response
  static void supabaseResponse(String method, String path, dynamic data) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.write('\n🔷 Supabase Response\n');
    buffer.write('⬅️  $method $path\n');

    if (supabaseLogLevel == LogLevel.BODY && data != null) {
      buffer.write('📦 Body:\n${_prettyJson(data)}\n');
    }

    _instance._logger.i(buffer.toString());
  }

  /// Log a Supabase error
  static void supabaseError(
    String method,
    String path,
    Object error,
    StackTrace? stackTrace,
  ) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.write('\n🔷 Supabase Error\n');
    buffer.write('❌ $method $path\n');
    buffer.write('Error: $error\n');

    if (error is PostgrestException) {
      buffer.write('📌 Details: ${error.details}\n');
      buffer.write('💡 Hint: ${error.hint}\n');
      buffer.write('🔢 Code: ${error.code}\n');
    }

    _instance._logger.e(
      buffer.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  // ==================== HELPER METHODS ====================

  /// Format a log message with emoji and data
  static String _formatMessage(String emoji, String message, dynamic data) {
    if (data == null) {
      return '$emoji $message';
    }
    return '$emoji $message\n   Data: ${_prettyJson(data)}';
  }

  /// Get Supabase headers for logging (with sensitive data filtered)
  static Map<String, String> _getSupabaseHeaders() {
    try {
      final client = Supabase.instance.client;
      return {
        'Authorization': 'Bearer ${client.auth.currentSession?.accessToken}',
        'apikey': client.auth.currentSession?.accessToken ?? '',
      };
    } catch (e) {
      return {'error': 'Could not retrieve headers'};
    }
  }

  /// Convert headers to a readable string (filters sensitive data)
  static String _stringifyHeaders(Map<String, dynamic> headers) {
    return headers.entries
        .map(
          (e) => e.key == 'Authorization' || e.key == 'apikey'
              ? '   ${e.key}: [FILTERED]'
              : '   ${e.key}: ${e.value}',
        )
        .join('\n');
  }

  /// Pretty print JSON with proper indentation
  static String _prettyJson(dynamic json) {
    try {
      if (json is Map || json is List) {
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(json);
      }
      return json.toString();
    } catch (e) {
      return json.toString();
    }
  }
}

/// Log level enum for Supabase logging
enum LogLevel {
  BASIC, // Only log method and path
  HEADERS, // Log method, path, and headers
  BODY, // Log method, path, headers, and body
}
