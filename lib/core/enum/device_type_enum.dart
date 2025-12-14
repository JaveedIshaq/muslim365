enum DeviceType {
  web('WEB'),
  android('ANDROID'),
  ios('IOS');

  const DeviceType(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static DeviceType fromJson(String value) {
    return DeviceType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => DeviceType.web, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case DeviceType.web:
        return 'Web';
      case DeviceType.android:
        return 'Android';
      case DeviceType.ios:
        return 'iOS';
    }
  }

  // Helper to check if it's a mobile device
  bool get isMobile => this == DeviceType.android || this == DeviceType.ios;

  // Helper to check if it's web
  bool get isWeb => this == DeviceType.web;
}
