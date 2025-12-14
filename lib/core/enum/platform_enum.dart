enum Platform {
  fcm('FCM'),
  web('WEB'),
  apns('APNS');

  const Platform(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static Platform fromJson(String value) {
    return Platform.values.firstWhere(
      (platform) => platform.value == value,
      orElse: () => Platform.fcm, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case Platform.fcm:
        return 'Firebase Cloud Messaging';
      case Platform.web:
        return 'Web';
      case Platform.apns:
        return 'Apple Push Notification Service';
    }
  }
}
