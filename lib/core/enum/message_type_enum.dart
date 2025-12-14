enum MessageType {
  text('TEXT'),
  image('IMAGE'),
  file('FILE'),
  system('SYSTEM');

  const MessageType(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static MessageType fromJson(String value) {
    return MessageType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MessageType.text, // Default fallback
    );
  }

  // UI Helper
  String get label {
    switch (this) {
      case MessageType.text:
        return 'Text Message';
      case MessageType.image:
        return 'Image';
      case MessageType.file:
        return 'File Attachment';
      case MessageType.system:
        return 'System Message';
    }
  }

  // Helper to check if it's a media message
  bool get isMedia => this == MessageType.image || this == MessageType.file;

  // Helper to check if it's a system message
  bool get isSystem => this == MessageType.system;
}
