import 'package:mobile/core/error/error.dart';

/// Generic network exception
class NetworkException implements Exception {
  final String message;
  final dynamic originalError;
  const NetworkException(this.message, this.originalError);

  @override
  String toString() => 'Network error: $message';
}

/// Generic resource not found exception
class ResourceNotFoundException implements Exception {
  final String resource;
  final String? id;
  const ResourceNotFoundException(this.resource, {this.id});

  @override
  String toString() => '$resource not found${id != null ? ': $id' : ''}';
}

/// Generic data parsing exception
class DataParsingException implements Exception {
  final String message;
  final dynamic originalError;
  const DataParsingException(this.message, this.originalError);

  @override
  String toString() => 'Parsing error: $message';
}

/// Exception thrown when a nurse profile is not found for an authenticated user
/// This indicates the user is authenticated but hasn't completed their nurse registration
class NurseProfileNotFoundException implements Exception {
  final String userId;
  final AppError originalError;
  const NurseProfileNotFoundException(this.userId, this.originalError);

  @override
  String toString() => 'Nurse profile not found for user: $userId';
}
