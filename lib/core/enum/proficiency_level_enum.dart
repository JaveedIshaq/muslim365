enum ProficiencyLevel {
  basic('BASIC'),
  intermediate('INTERMEDIATE'),
  advanced('ADVANCED'),
  expert('EXPERT');

  const ProficiencyLevel(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static ProficiencyLevel fromJson(String value) {
    return ProficiencyLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => ProficiencyLevel.basic, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case ProficiencyLevel.basic:
        return 'Basic';
      case ProficiencyLevel.intermediate:
        return 'Intermediate';
      case ProficiencyLevel.advanced:
        return 'Advanced';
      case ProficiencyLevel.expert:
        return 'Expert';
    }
  }
}
