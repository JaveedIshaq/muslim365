import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

/// Centralized logging service for the application
///
/// Features:
/// - Multi-level logging (debug, info, warning, error)
/// - Console output in debug mode
/// - File output for persistence
/// - Daily log rotation
/// - PII filtering
/// - Correlation IDs for tracing
class AppLogger {
  static AppLogger? _instance;
  Logger? _logger;
  File? _logFile;
  bool _isInitialized = false;

  AppLogger._();

  /// Get the singleton instance
  static AppLogger get instance {
    _instance ??= AppLogger._();
    return _instance!;
  }

  /// Initialize the logger
  /// Must be called before using any logging methods
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Get the log file path
      _logFile = await _getLogFile();

      // Create logger with custom configuration
      _logger = Logger(
        filter: _LogFilter(),
        printer: _AppLogPrinter(),
        output: _FileOutput(_logFile!),
        level: kDebugMode ? Level.debug : Level.info,
      );

      _isInitialized = true;
      _logger!.i('AppLogger initialized - Log file: ${_logFile!.path}');
    } catch (e) {
      debugPrint('Failed to initialize AppLogger: $e');
      // Fallback to simple logger without file output
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: true,
        ),
      );
      _isInitialized = true;
    }
  }

  /// Get the current log file
  Future<File> _getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final logsDir = Directory('${directory.path}/logs');

    // Create logs directory if it doesn't exist
    if (!await logsDir.exists()) {
      await logsDir.create(recursive: true);
    }

    // Create daily log file
    final dateFormat = DateFormat('yyyy-MM-dd');
    final today = dateFormat.format(DateTime.now());
    final logFile = File('${logsDir.path}/app_log_$today.txt');

    // Rotate old logs (keep last 7 days)
    await _rotateOldLogs(logsDir);

    return logFile;
  }

  /// Remove log files older than 7 days
  Future<void> _rotateOldLogs(Directory logsDir) async {
    try {
      final files = logsDir.listSync();
      final now = DateTime.now();

      for (var file in files) {
        if (file is File && file.path.endsWith('.txt')) {
          final stats = await file.stat();
          final age = now.difference(stats.modified);

          // Delete files older than 7 days
          if (age.inDays > 7) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to rotate old logs: $e');
    }
  }

  /// Get the path to the current log file
  String? get logFilePath => _logFile?.path;

  /// Debug level log
  void debug(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    _ensureInitialized();
    _logger!.d(
      _formatMessage(message, context),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Info level log
  void info(String message, {Map<String, dynamic>? context}) {
    _ensureInitialized();
    _logger!.i(_formatMessage(message, context));
  }

  /// Warning level log
  void warning(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    _ensureInitialized();
    _logger!.w(
      _formatMessage(message, context),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Error level log
  void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    _ensureInitialized();
    _logger!.e(
      _formatMessage(message, context),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Fatal/critical error log
  void fatal(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    _ensureInitialized();
    _logger!.f(
      _formatMessage(message, context),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Format message with optional context
  String _formatMessage(String message, Map<String, dynamic>? context) {
    if (context == null || context.isEmpty) {
      return message;
    }

    final contextStr = context.entries
        .map((e) => '${e.key}=${_sanitizeValue(e.value)}')
        .join(', ');

    return '$message | Context: {$contextStr}';
  }

  /// Sanitize values to avoid logging PII
  String _sanitizeValue(dynamic value) {
    if (value == null) return 'null';

    final valueStr = value.toString();

    // Detect and sanitize potential PII patterns
    // Email addresses
    if (valueStr.contains('@')) {
      return valueStr.replaceAllMapped(
        RegExp(r'([^@\s]+)@([^@\s]+)'),
        (match) => '***@${match.group(2)}',
      );
    }

    // Phone numbers (simple pattern)
    if (RegExp(r'^\+?\d{10,}$').hasMatch(valueStr)) {
      return '***${valueStr.substring(valueStr.length - 4)}';
    }

    // Long strings might be tokens or sensitive data
    if (valueStr.length > 50) {
      return '${valueStr.substring(0, 10)}...[${valueStr.length} chars]';
    }

    return valueStr;
  }

  /// Ensure logger is initialized before use
  void _ensureInitialized() {
    if (!_isInitialized) {
      debugPrint('AppLogger not initialized. Call initialize() first.');
      // Auto-initialize with fallback
      initialize();
    }
  }

  /// Clear all log files
  Future<void> clearLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/logs');

      if (await logsDir.exists()) {
        await logsDir.delete(recursive: true);
        await logsDir.create();
      }

      info('All logs cleared');
    } catch (e) {
      error('Failed to clear logs', error: e);
    }
  }

  /// Get all log content as a string (for sharing/debugging)
  Future<String> getLogsContent() async {
    try {
      if (_logFile == null || !await _logFile!.exists()) {
        return 'No logs available';
      }

      return await _logFile!.readAsString();
    } catch (e) {
      return 'Error reading logs: $e';
    }
  }
}

/// Custom log filter - only log in debug mode or if level is warning or above
class _LogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kDebugMode) return true;
    return event.level.index >= Level.warning.index;
  }
}

/// Custom log printer with timestamp and clean format
class _AppLogPrinter extends LogPrinter {
  static final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

  @override
  List<String> log(LogEvent event) {
    final timestamp = _dateFormat.format(DateTime.now());
    final level = event.level.name.toUpperCase().padRight(7);
    final message = event.message;

    final buffer = StringBuffer();
    buffer.write('[$timestamp] [$level] $message');

    if (event.error != null) {
      buffer.write('\nError: ${event.error}');
    }

    if (event.stackTrace != null) {
      buffer.write('\nStackTrace:\n${event.stackTrace}');
    }

    return [buffer.toString()];
  }
}

/// Custom output that writes to both console and file
class _FileOutput extends LogOutput {
  final File file;
  final IOSink _sink;

  _FileOutput(this.file) : _sink = file.openWrite(mode: FileMode.append);

  @override
  void output(OutputEvent event) {
    // Write to file
    for (var line in event.lines) {
      _sink.writeln(line);
      // Also print to console in debug mode
      if (kDebugMode) {
        debugPrint(line);
      }
    }
  }

  @override
  Future<void> destroy() async {
    await _sink.close();
  }
}

/// Extension for easy access to logger
extension AppLoggerExtension on Object {
  AppLogger get logger => AppLogger.instance;
}
