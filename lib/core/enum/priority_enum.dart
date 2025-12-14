import 'package:flutter/material.dart';

enum Priority {
  low('LOW'),
  normal('NORMAL'),
  high('HIGH'),
  urgent('URGENT');

  const Priority(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static Priority fromJson(String value) {
    return Priority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => Priority.normal, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.normal:
        return 'Normal';
      case Priority.high:
        return 'High';
      case Priority.urgent:
        return 'Urgent';
    }
  }

  // Color Helper
  Color get color {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.normal:
        return Colors.blue;
      case Priority.high:
        return Colors.orange;
      case Priority.urgent:
        return Colors.red;
    }
  }
}
