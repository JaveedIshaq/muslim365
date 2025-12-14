enum UserRole {
  nurse('NURSE'),
  hospital('HOSPITAL'),
  admin('ADMIN'),
  agency('AGENCY');

  const UserRole(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static UserRole fromJson(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.nurse, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case UserRole.nurse:
        return 'Nurse';
      case UserRole.hospital:
        return 'Hospital';
      case UserRole.admin:
        return 'Admin';
      case UserRole.agency:
        return 'Agency';
    }
  }
}
