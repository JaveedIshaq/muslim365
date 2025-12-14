enum BannerStatus {
  active('ACTIVE'),
  inactive('INACTIVE'),
  scheduled('SCHEDULED'),
  expired('EXPIRED');

  const BannerStatus(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static BannerStatus fromJson(String value) {
    return BannerStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => BannerStatus.inactive, // Default fallback
    );
  }

  // Computed Property
  bool get isVisible {
    return this == BannerStatus.active;
  }

  // UI Helper
  String get label {
    switch (this) {
      case BannerStatus.active:
        return 'Live Now';
      case BannerStatus.scheduled:
        return 'Coming Soon';
      case BannerStatus.expired:
        return 'Finished';
      case BannerStatus.inactive:
        return 'Draft';
    }
  }
}
