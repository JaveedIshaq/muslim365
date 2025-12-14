enum DeliveryMethod {
  inApp('IN_APP'),
  push('PUSH'),
  email('EMAIL'),
  sms('SMS');

  const DeliveryMethod(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static DeliveryMethod fromJson(String value) {
    return DeliveryMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () => DeliveryMethod.inApp, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case DeliveryMethod.inApp:
        return 'In-App Notification';
      case DeliveryMethod.push:
        return 'Push Notification';
      case DeliveryMethod.email:
        return 'Email';
      case DeliveryMethod.sms:
        return 'SMS';
    }
  }
}
