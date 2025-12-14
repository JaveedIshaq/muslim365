enum ParticipantRole {
  admin('ADMIN'),
  member('MEMBER');

  const ParticipantRole(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static ParticipantRole fromJson(String value) {
    return ParticipantRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => ParticipantRole.member, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case ParticipantRole.admin:
        return 'Admin';
      case ParticipantRole.member:
        return 'Member';
    }
  }

  // Helper to check if admin
  bool get isAdmin => this == ParticipantRole.admin;
}
