import 'package:flutter/material.dart';

enum VerificationStatus {
  pending('PENDING'),
  verified('VERIFIED'),
  rejected('REJECTED'),
  expired('EXPIRED');

  const VerificationStatus(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static VerificationStatus fromJson(String value) {
    return VerificationStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => VerificationStatus.pending, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.expired:
        return 'Expired';
    }
  }

  // Color Helper
  Color get color {
    switch (this) {
      case VerificationStatus.pending:
        return Colors.orange;
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.rejected:
        return Colors.red;
      case VerificationStatus.expired:
        return Colors.grey;
    }
  }

  String get description {
    switch (this) {
      case VerificationStatus.pending:
        return 'Document is pending review';
      case VerificationStatus.verified:
        return 'Document has been verified and approved';
      case VerificationStatus.rejected:
        return 'Document has been rejected and needs resubmission';
      case VerificationStatus.expired:
        return 'Document has expired and needs renewal';
    }
  }

  bool get isCompleted {
    switch (this) {
      case VerificationStatus.verified:
      case VerificationStatus.expired:
        return true;
      case VerificationStatus.pending:
      case VerificationStatus.rejected:
        return false;
    }
  }
}

/// Extension on String to convert string values to VerificationStatus enum
extension StringToVerificationStatusX on String {
  /// Converts a string to a VerificationStatus enum value
  ///
  /// Matches the @JsonValue annotations in the enum definition
  /// Returns null if the string doesn't match any enum value
  VerificationStatus? toEnum() {
    switch (toUpperCase()) {
      case 'PENDING':
        return VerificationStatus.pending;
      case 'VERIFIED':
        return VerificationStatus.verified;
      case 'REJECTED':
        return VerificationStatus.rejected;
      case 'EXPIRED':
        return VerificationStatus.expired;
      default:
        return VerificationStatus.pending;
    }
  }
}
