enum HospitalType {
  public('PUBLIC'),
  private('PRIVATE'),
  clinic('CLINIC');

  const HospitalType(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static HospitalType fromJson(String value) {
    return HospitalType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => HospitalType.public, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case HospitalType.public:
        return 'Public Hospital';
      case HospitalType.private:
        return 'Private Hospital';
      case HospitalType.clinic:
        return 'Clinic';
    }
  }
}
