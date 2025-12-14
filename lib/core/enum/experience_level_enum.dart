enum ExperienceLevel {
  entry('ENTRY'),
  mid('MID'),
  senior('SENIOR'),
  expert('EXPERT');

  const ExperienceLevel(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static ExperienceLevel fromJson(String value) {
    return ExperienceLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => ExperienceLevel.entry, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case ExperienceLevel.entry:
        return 'Entry Level';
      case ExperienceLevel.mid:
        return 'Mid Level';
      case ExperienceLevel.senior:
        return 'Senior Level';
      case ExperienceLevel.expert:
        return 'Expert';
    }
  }
}
