/// Represents the different registration states a user can be in
enum RegistrationStatusEnum {
  notStarted('NOT_STARTED'),
  accountCreated('ACCOUNT_CREATED'),
  emailVerified('EMAIL_VERIFIED'),
  professionalCompleted('PROFESSIONAL_COMPLETED'),
  locationCompleted('LOCATION_COMPLETED'),
  documentsCompleted('DOCUMENTS_COMPLETED'),
  inProgress('IN_PROGRESS'),
  pendingApproval('PENDING_APPROVAL'),
  completed('COMPLETED'),
  rejected('REJECTED');

  const RegistrationStatusEnum(this.value);
  final String value;

  /// Converts the enum to a string value for JSON serialization
  String toJson() => value;

  /// Creates an enum instance from a JSON string value
  static RegistrationStatusEnum fromJson(String value) {
    return RegistrationStatusEnum.values.firstWhere(
      (status) => status.value == value,
      orElse: () => RegistrationStatusEnum.notStarted,
    );
  }

  /// Returns the display name for the status
  String get displayName {
    switch (this) {
      case RegistrationStatusEnum.notStarted:
        return 'Not Started';
      case RegistrationStatusEnum.accountCreated:
        return 'Account Created';
      case RegistrationStatusEnum.emailVerified:
        return 'Email Verified';
      case RegistrationStatusEnum.professionalCompleted:
        return 'Professional Details Completed';
      case RegistrationStatusEnum.locationCompleted:
        return 'Location Details Completed';
      case RegistrationStatusEnum.documentsCompleted:
        return 'Documents Uploaded';
      case RegistrationStatusEnum.inProgress:
        return 'In Progress';
      case RegistrationStatusEnum.pendingApproval:
        return 'Pending Approval';
      case RegistrationStatusEnum.completed:
        return 'Completed';
      case RegistrationStatusEnum.rejected:
        return 'Rejected';
    }
  }

  /// Returns true if the registration is complete
  bool get isComplete => this == RegistrationStatusEnum.completed;

  /// Returns true if the registration is pending any action
  bool get isPending => !isComplete && this != RegistrationStatusEnum.rejected;

  /// Returns the next expected step in the registration process
  String get nextStep {
    switch (this) {
      case RegistrationStatusEnum.notStarted:
        return 'Create your account';
      case RegistrationStatusEnum.accountCreated:
        return 'Verify your email address';
      case RegistrationStatusEnum.emailVerified:
        return 'Complete professional details';
      case RegistrationStatusEnum.professionalCompleted:
        return 'Complete location details';
      case RegistrationStatusEnum.locationCompleted:
        return 'Upload required documents';
      case RegistrationStatusEnum.documentsCompleted:
      case RegistrationStatusEnum.inProgress:
      case RegistrationStatusEnum.pendingApproval:
        return 'Wait for admin approval';
      case RegistrationStatusEnum.completed:
        return 'Registration complete';
      case RegistrationStatusEnum.rejected:
        return 'Please contact support';
    }
  }

  /// Returns the progress percentage for the registration process
  int get progressPercentage {
    switch (this) {
      case RegistrationStatusEnum.notStarted:
        return 0;
      case RegistrationStatusEnum.accountCreated:
        return 10;
      case RegistrationStatusEnum.emailVerified:
        return 20;
      case RegistrationStatusEnum.professionalCompleted:
        return 50;
      case RegistrationStatusEnum.locationCompleted:
        return 70;
      case RegistrationStatusEnum.documentsCompleted:
        return 90;
      case RegistrationStatusEnum.inProgress:
        return 50; // Generic in-progress state
      case RegistrationStatusEnum.pendingApproval:
        return 95;
      case RegistrationStatusEnum.completed:
        return 100;
      case RegistrationStatusEnum.rejected:
        return 0;
    }
  }
}
