import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// JSON converter for TimeOfDay objects
class TimeOfDayJsonConverter implements JsonConverter<TimeOfDay, dynamic> {
  const TimeOfDayJsonConverter();

  @override
  TimeOfDay fromJson(dynamic json) {
    if (json is String) {
      // Handle TIME format from database (HH:MM)
      final parts = json.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } else if (json is Map<String, dynamic>) {
      // Handle object format from JSONB
      return TimeOfDay(
        hour: json['hour'] as int,
        minute: json['minute'] as int,
      );
    }

    // Default fallback
    return const TimeOfDay(hour: 0, minute: 0);
  }

  @override
  Map<String, dynamic> toJson(TimeOfDay object) {
    return {
      'hour': object.hour,
      'minute': object.minute,
    };
  }
}

/// String converter for TimeOfDay objects (for database TIME columns)
class TimeOfDayStringConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayStringConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour.toString().padLeft(2, '0')}:${object.minute.toString().padLeft(2, '0')}';
  }
}

/// Duration converter for work hour calculations
class DurationMinutesConverter implements JsonConverter<Duration, int> {
  const DurationMinutesConverter();

  @override
  Duration fromJson(int json) {
    return Duration(minutes: json);
  }

  @override
  int toJson(Duration object) {
    return object.inMinutes;
  }
}