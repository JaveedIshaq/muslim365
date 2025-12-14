import 'package:flutter/material.dart';

enum UserStatus {
  active('ACTIVE'),
  inactive('INACTIVE'),
  suspended('SUSPENDED'),
  deleted('DELETED');

  const UserStatus(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static UserStatus fromJson(String value) {
    return UserStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => UserStatus.active, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
      case UserStatus.suspended:
        return 'Suspended';
      case UserStatus.deleted:
        return 'Deleted';
    }
  }

  // Color Helper
  Color get color {
    switch (this) {
      case UserStatus.active:
        return Colors.green;
      case UserStatus.inactive:
        return Colors.grey;
      case UserStatus.suspended:
        return Colors.orange;
      case UserStatus.deleted:
        return Colors.red;
    }
  }
}
