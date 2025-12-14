enum ConversationType {
  direct('DIRECT'),
  group('GROUP'),
  support('SUPPORT');

  const ConversationType(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static ConversationType fromJson(String value) {
    return ConversationType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ConversationType.direct, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case ConversationType.direct:
        return 'Direct Message';
      case ConversationType.group:
        return 'Group Chat';
      case ConversationType.support:
        return 'Support';
    }
  }

  // Helper to check if it's a group conversation
  bool get isGroup => this == ConversationType.group;

  // Helper to check if it's a support conversation
  bool get isSupport => this == ConversationType.support;
}
