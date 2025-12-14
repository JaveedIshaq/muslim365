import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Heroes of Computer Science'**
  String get appTitle;

  /// No description provided for @appAppearance.
  ///
  /// In en, this message translates to:
  /// **'App Appearance'**
  String get appAppearance;

  /// No description provided for @uploadDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocumentsTitle;

  /// No description provided for @uploadDocumentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please upload the required documents to complete your registration.'**
  String get uploadDocumentsSubtitle;

  /// No description provided for @registrationCertificate.
  ///
  /// In en, this message translates to:
  /// **'Registration Certificate'**
  String get registrationCertificate;

  /// No description provided for @registrationCertificateDescription.
  ///
  /// In en, this message translates to:
  /// **'Your nursing registration certificate'**
  String get registrationCertificateDescription;

  /// No description provided for @idDocument.
  ///
  /// In en, this message translates to:
  /// **'ID Document'**
  String get idDocument;

  /// No description provided for @idDocumentDescription.
  ///
  /// In en, this message translates to:
  /// **'Valid South African ID or passport'**
  String get idDocumentDescription;

  /// No description provided for @nursingQualifications.
  ///
  /// In en, this message translates to:
  /// **'Nursing Qualifications'**
  String get nursingQualifications;

  /// No description provided for @nursingQualificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Nursing degree/diploma certificates'**
  String get nursingQualificationsDescription;

  /// No description provided for @cvResume.
  ///
  /// In en, this message translates to:
  /// **'CV/Resume'**
  String get cvResume;

  /// No description provided for @cvResumeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your current CV or resume'**
  String get cvResumeDescription;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additionalNotes;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @uploadAllRequiredDocuments.
  ///
  /// In en, this message translates to:
  /// **'Please upload all required documents before continuing'**
  String get uploadAllRequiredDocuments;

  /// No description provided for @documentsUploaded.
  ///
  /// In en, this message translates to:
  /// **'Documents Uploaded'**
  String get documentsUploaded;

  /// No description provided for @documentRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get documentRequired;

  /// No description provided for @documentOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get documentOptional;

  /// No description provided for @loadingDocuments.
  ///
  /// In en, this message translates to:
  /// **'Loading documents...'**
  String get loadingDocuments;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorMessage;

  /// No description provided for @locationRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Location & Rates'**
  String get locationRatesTitle;

  /// No description provided for @locationRatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your preferred hourly rates and maximum travel distance.'**
  String get locationRatesSubtitle;

  /// No description provided for @hourlyRateRange.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate Range'**
  String get hourlyRateRange;

  /// No description provided for @minimumRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rate'**
  String get minimumRateLabel;

  /// No description provided for @maximumRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum Rate'**
  String get maximumRateLabel;

  /// No description provided for @minimumRateHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 250'**
  String get minimumRateHint;

  /// No description provided for @maximumRateHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 450'**
  String get maximumRateHint;

  /// No description provided for @travelPreferences.
  ///
  /// In en, this message translates to:
  /// **'Travel Preferences'**
  String get travelPreferences;

  /// No description provided for @maximumTravelDistance.
  ///
  /// In en, this message translates to:
  /// **'Maximum Travel Distance'**
  String get maximumTravelDistance;

  /// No description provided for @travelDistanceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 50'**
  String get travelDistanceHint;

  /// No description provided for @travelDistanceUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get travelDistanceUnit;

  /// No description provided for @rateUpdateInfo.
  ///
  /// In en, this message translates to:
  /// **'You can update these preferences anytime in your profile settings.'**
  String get rateUpdateInfo;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalidRate.
  ///
  /// In en, this message translates to:
  /// **'Invalid rate'**
  String get invalidRate;

  /// No description provided for @rateTooLow.
  ///
  /// In en, this message translates to:
  /// **'Rate too low'**
  String get rateTooLow;

  /// No description provided for @mustBeGreaterThanMinRate.
  ///
  /// In en, this message translates to:
  /// **'Must be ≥ min rate'**
  String get mustBeGreaterThanMinRate;

  /// No description provided for @invalidDistance.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid distance'**
  String get invalidDistance;

  /// No description provided for @distanceTooHigh.
  ///
  /// In en, this message translates to:
  /// **'Distance must be less than 500km'**
  String get distanceTooHigh;

  /// No description provided for @currencySymbol.
  ///
  /// In en, this message translates to:
  /// **'R'**
  String get currencySymbol;

  /// No description provided for @reviewSubmitTitle.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get reviewSubmitTitle;

  /// No description provided for @reviewSubmitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please review your information before submitting your registration.'**
  String get reviewSubmitSubtitle;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @professionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Professional Details'**
  String get professionalDetails;

  /// No description provided for @locationRates.
  ///
  /// In en, this message translates to:
  /// **'Location & Rates'**
  String get locationRates;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @uploadedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Documents'**
  String get uploadedDocuments;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @confirmAccuracy.
  ///
  /// In en, this message translates to:
  /// **'I confirm that all information provided is accurate and complete'**
  String get confirmAccuracy;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get agreeToTerms;

  /// No description provided for @submitRegistration.
  ///
  /// In en, this message translates to:
  /// **'Submit Registration'**
  String get submitRegistration;

  /// No description provided for @whatHappensNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next?'**
  String get whatHappensNext;

  /// No description provided for @submissionInfo.
  ///
  /// In en, this message translates to:
  /// **'Your registration will be reviewed by our team. You\'ll receive an email notification once the review is complete.'**
  String get submissionInfo;

  /// No description provided for @confirmAllCheckboxes.
  ///
  /// In en, this message translates to:
  /// **'Please confirm all checkboxes before submitting'**
  String get confirmAllCheckboxes;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @registrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration Number'**
  String get registrationNumber;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsOfExperience;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @employmentType.
  ///
  /// In en, this message translates to:
  /// **'Employment Type'**
  String get employmentType;

  /// No description provided for @maxTravelDistance.
  ///
  /// In en, this message translates to:
  /// **'Max Travel Distance'**
  String get maxTravelDistance;

  /// No description provided for @notProvided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @noneSelected.
  ///
  /// In en, this message translates to:
  /// **'None selected'**
  String get noneSelected;

  /// No description provided for @uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get uploaded;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @registrationStatus.
  ///
  /// In en, this message translates to:
  /// **'Registration Status'**
  String get registrationStatus;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get underReview;

  /// No description provided for @profileComplete.
  ///
  /// In en, this message translates to:
  /// **'Profile Complete'**
  String get profileComplete;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStarted;

  /// No description provided for @approvedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your registration has been approved! You can now access all features of the app.'**
  String get approvedMessage;

  /// No description provided for @rejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your registration has been rejected. Please contact support for more information.'**
  String get rejectedMessage;

  /// No description provided for @underReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Your application is under review. This process typically takes 2-3 business days. You will be notified once a decision has been made.'**
  String get underReviewMessage;

  /// No description provided for @documentsUploadedMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for submitting your documents. Our team will review them and update your status shortly.'**
  String get documentsUploadedMessage;

  /// No description provided for @profileCompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Your profile is complete! Please proceed to upload your documents to continue with the registration process.'**
  String get profileCompleteMessage;

  /// No description provided for @emailVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your email has been verified. Please complete your profile to continue.'**
  String get emailVerifiedMessage;

  /// No description provided for @notStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'Please complete your registration to get started.'**
  String get notStartedMessage;

  /// No description provided for @goToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get goToDashboard;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @reapply.
  ///
  /// In en, this message translates to:
  /// **'Reapply'**
  String get reapply;

  /// No description provided for @reviewingDocuments.
  ///
  /// In en, this message translates to:
  /// **'Reviewing your documents...'**
  String get reviewingDocuments;

  /// No description provided for @continueRegistration.
  ///
  /// In en, this message translates to:
  /// **'Continue Registration'**
  String get continueRegistration;

  /// No description provided for @needHelpContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Need help? Contact Support'**
  String get needHelpContactSupport;

  /// No description provided for @registrationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Registration submitted successfully! Your application is now under review.'**
  String get registrationSubmitted;

  /// No description provided for @registrationSubmittedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your registration has been submitted for review. You will receive an email notification once the review is complete.'**
  String get registrationSubmittedMessage;

  /// No description provided for @registrationError.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get registrationError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fillInDetailsToStart.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started'**
  String get fillInDetailsToStart;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameHint;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get lastNameHint;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumber;

  /// No description provided for @licenseNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your license number'**
  String get licenseNumberHint;

  /// No description provided for @discipline.
  ///
  /// In en, this message translates to:
  /// **'Discipline'**
  String get discipline;

  /// No description provided for @selectDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Select Discipline'**
  String get selectDiscipline;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @pleaseEnterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get pleaseEnterFirstName;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get pleaseEnterLastName;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhone;

  /// No description provided for @pleaseEnterYourLicense.
  ///
  /// In en, this message translates to:
  /// **'Please enter your license number'**
  String get pleaseEnterYourLicense;

  /// No description provided for @pleaseSelectYourDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Please select your discipline'**
  String get pleaseSelectYourDiscipline;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhone;

  /// No description provided for @passwordAtLeastSixChars.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordAtLeastSixChars;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @cna.
  ///
  /// In en, this message translates to:
  /// **'CNA'**
  String get cna;

  /// No description provided for @lpn.
  ///
  /// In en, this message translates to:
  /// **'LPN'**
  String get lpn;

  /// No description provided for @rn.
  ///
  /// In en, this message translates to:
  /// **'RN'**
  String get rn;

  /// No description provided for @lvn.
  ///
  /// In en, this message translates to:
  /// **'LVN'**
  String get lvn;

  /// No description provided for @stna.
  ///
  /// In en, this message translates to:
  /// **'STNA'**
  String get stna;

  /// No description provided for @pleaseSelectAtLeastOneSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one specialty'**
  String get pleaseSelectAtLeastOneSpecialty;

  /// No description provided for @tellUsAboutYourNursingQualifications.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your nursing qualifications and experience.'**
  String get tellUsAboutYourNursingQualifications;

  /// No description provided for @nursingRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Nursing Registration Number'**
  String get nursingRegistrationNumber;

  /// No description provided for @yourSancRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Your SANC registration number'**
  String get yourSancRegistrationNumber;

  /// No description provided for @registrationNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Registration number is required'**
  String get registrationNumberIsRequired;

  /// No description provided for @pleaseEnterAValidRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid registration number'**
  String get pleaseEnterAValidRegistrationNumber;

  /// No description provided for @licenseExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'License Expiry Date'**
  String get licenseExpiryDate;

  /// No description provided for @selectExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Select expiry date'**
  String get selectExpiryDate;

  /// No description provided for @yearsOfExperienceIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Years of experience is required'**
  String get yearsOfExperienceIsRequired;

  /// No description provided for @pleaseEnterAValidNumberOfYears.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number of years (0-50)'**
  String get pleaseEnterAValidNumberOfYears;

  /// No description provided for @selectYourAreasOfSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Select your areas of specialization'**
  String get selectYourAreasOfSpecialization;

  /// No description provided for @certifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certifications;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noCertificationsAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No certifications added yet'**
  String get noCertificationsAddedYet;

  /// No description provided for @professionalBio.
  ///
  /// In en, this message translates to:
  /// **'Professional Bio'**
  String get professionalBio;

  /// No description provided for @briefDescriptionOfYourExperienceAndSkills.
  ///
  /// In en, this message translates to:
  /// **'Brief description of your experience and skills (optional)'**
  String get briefDescriptionOfYourExperienceAndSkills;

  /// No description provided for @addCertification.
  ///
  /// In en, this message translates to:
  /// **'Add Certification'**
  String get addCertification;

  /// No description provided for @certificationName.
  ///
  /// In en, this message translates to:
  /// **'Certification Name'**
  String get certificationName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @pleaseProvideYourPersonalDetails.
  ///
  /// In en, this message translates to:
  /// **'Please provide your personal details to complete your profile.'**
  String get pleaseProvideYourPersonalDetails;

  /// No description provided for @thisIsYourRegisteredEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'This is your registered email address'**
  String get thisIsYourRegisteredEmailAddress;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get confirm;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @onBoardingSlideOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to NurseLife'**
  String get onBoardingSlideOneTitle;

  /// No description provided for @onBoardingSlideOneDesc.
  ///
  /// In en, this message translates to:
  /// **'Your trusted platform for finding flexible nursing shifts and career opportunities.'**
  String get onBoardingSlideOneDesc;

  /// No description provided for @onBoardingSlideTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Your Perfect Shift'**
  String get onBoardingSlideTwoTitle;

  /// No description provided for @onBoardingSlideTwoDesc.
  ///
  /// In en, this message translates to:
  /// **'Browse and filter through available shifts that match your schedule and preferences.'**
  String get onBoardingSlideTwoDesc;

  /// No description provided for @onBoardingSlideThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant Connections'**
  String get onBoardingSlideThreeTitle;

  /// No description provided for @onBoardingSlideThreeDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with healthcare facilities and manage your assignments seamlessly.'**
  String get onBoardingSlideThreeDesc;

  /// No description provided for @onBoardingSlideFourTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure Payments'**
  String get onBoardingSlideFourTitle;

  /// No description provided for @onBoardingSlideFourDesc.
  ///
  /// In en, this message translates to:
  /// **'Get paid quickly and securely for your completed shifts with transparent payment tracking.'**
  String get onBoardingSlideFourDesc;

  /// No description provided for @onBoardingSlideFiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible Scheduling'**
  String get onBoardingSlideFiveTitle;

  /// No description provided for @onBoardingSlideFiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Take control of your work schedule with our intuitive calendar and booking system.'**
  String get onBoardingSlideFiveDesc;

  /// No description provided for @onBoardingSlideSixTitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time Updates'**
  String get onBoardingSlideSixTitle;

  /// No description provided for @onBoardingSlideSixDesc.
  ///
  /// In en, this message translates to:
  /// **'Stay informed with instant notifications about shift confirmations and important updates.'**
  String get onBoardingSlideSixDesc;

  /// No description provided for @onBoardingSlideSevenTitle.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get onBoardingSlideSevenTitle;

  /// No description provided for @onBoardingSlideSevenDesc.
  ///
  /// In en, this message translates to:
  /// **'Join thousands of healthcare professionals who trust NurseLife for their career growth.'**
  String get onBoardingSlideSevenDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More Options'**
  String get moreOptions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndServices.
  ///
  /// In en, this message translates to:
  /// **'Terms and Services'**
  String get termsAndServices;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeMessage;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @statusError.
  ///
  /// In en, this message translates to:
  /// **'Status Error'**
  String get statusError;

  /// No description provided for @updateAvailabilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Availability Status'**
  String get updateAvailabilityStatus;

  /// No description provided for @currentlyAvailable.
  ///
  /// In en, this message translates to:
  /// **'Currently Available'**
  String get currentlyAvailable;

  /// No description provided for @currentlyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Currently Unavailable'**
  String get currentlyUnavailable;

  /// No description provided for @availableDescription.
  ///
  /// In en, this message translates to:
  /// **'You will receive shift notifications and can book new shifts'**
  String get availableDescription;

  /// No description provided for @unavailableDescription.
  ///
  /// In en, this message translates to:
  /// **'You will not receive shift notifications and cannot book new shifts'**
  String get unavailableDescription;

  /// No description provided for @availableForShifts.
  ///
  /// In en, this message translates to:
  /// **'Available for Shifts'**
  String get availableForShifts;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatus;

  /// No description provided for @availabilityUpdatedAvailable.
  ///
  /// In en, this message translates to:
  /// **'You are now available for shifts'**
  String get availabilityUpdatedAvailable;

  /// No description provided for @availabilityUpdatedUnavailable.
  ///
  /// In en, this message translates to:
  /// **'You are now unavailable for shifts'**
  String get availabilityUpdatedUnavailable;

  /// No description provided for @availabilityUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update availability'**
  String get availabilityUpdateError;

  /// No description provided for @nextShift.
  ///
  /// In en, this message translates to:
  /// **'Next Shift'**
  String get nextShift;

  /// No description provided for @noUpcomingShifts.
  ///
  /// In en, this message translates to:
  /// **'No upcoming shifts'**
  String get noUpcomingShifts;

  /// No description provided for @loadingSchedule.
  ///
  /// In en, this message translates to:
  /// **'Loading schedule...'**
  String get loadingSchedule;

  /// No description provided for @scheduleNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Schedule not available'**
  String get scheduleNotAvailable;

  /// No description provided for @currentlyAt.
  ///
  /// In en, this message translates to:
  /// **'Currently at'**
  String get currentlyAt;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @hospitalLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading hospital...'**
  String get hospitalLoading;

  /// No description provided for @shifts.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get shifts;

  /// No description provided for @availableShifts.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get availableShifts;

  /// No description provided for @appliedShifts.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get appliedShifts;

  /// No description provided for @myShifts.
  ///
  /// In en, this message translates to:
  /// **'My Shifts'**
  String get myShifts;

  /// No description provided for @shiftHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get shiftHistory;

  /// No description provided for @hospitalShifts.
  ///
  /// In en, this message translates to:
  /// **'Hospital Shifts'**
  String get hospitalShifts;

  /// No description provided for @allShifts.
  ///
  /// In en, this message translates to:
  /// **'All Shifts'**
  String get allShifts;

  /// No description provided for @errorLoadingShifts.
  ///
  /// In en, this message translates to:
  /// **'Error loading available shifts'**
  String get errorLoadingShifts;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noAvailableShifts.
  ///
  /// In en, this message translates to:
  /// **'No available shifts'**
  String get noAvailableShifts;

  /// No description provided for @noAvailableShiftsDescription.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or check back later'**
  String get noAvailableShiftsDescription;

  /// No description provided for @adjustFilters.
  ///
  /// In en, this message translates to:
  /// **'Adjust Filters'**
  String get adjustFilters;

  /// No description provided for @findShifts.
  ///
  /// In en, this message translates to:
  /// **'Find Shifts'**
  String get findShifts;

  /// No description provided for @noApplicationsYet.
  ///
  /// In en, this message translates to:
  /// **'No applications yet'**
  String get noApplicationsYet;

  /// No description provided for @noApplicationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Start applying to shifts to track your applications'**
  String get noApplicationsDescription;

  /// No description provided for @noUpcomingShiftsDescription.
  ///
  /// In en, this message translates to:
  /// **'Your assigned shifts will appear here'**
  String get noUpcomingShiftsDescription;

  /// No description provided for @noWorkHistory.
  ///
  /// In en, this message translates to:
  /// **'No work history'**
  String get noWorkHistory;

  /// No description provided for @noWorkHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Your completed shifts will appear here'**
  String get noWorkHistoryDescription;

  /// No description provided for @applyForShift.
  ///
  /// In en, this message translates to:
  /// **'Applied to shift: {shiftTitle}'**
  String applyForShift(Object shiftTitle);

  /// No description provided for @shiftDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift Details'**
  String get shiftDetails;

  /// No description provided for @filterShifts.
  ///
  /// In en, this message translates to:
  /// **'Filter Shifts'**
  String get filterShifts;

  /// No description provided for @refreshShifts.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshShifts;

  /// No description provided for @createShift.
  ///
  /// In en, this message translates to:
  /// **'Create Shift'**
  String get createShift;

  /// No description provided for @hospitalIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Hospital ID is required to create shifts'**
  String get hospitalIdRequired;

  /// No description provided for @createShiftDialog.
  ///
  /// In en, this message translates to:
  /// **'Create shift dialog - TODO'**
  String get createShiftDialog;

  /// No description provided for @editShift.
  ///
  /// In en, this message translates to:
  /// **'Editing shift: {shiftTitle}'**
  String editShift(Object shiftTitle);

  /// No description provided for @assignShift.
  ///
  /// In en, this message translates to:
  /// **'Assigning shift: {shiftTitle}'**
  String assignShift(Object shiftTitle);

  /// No description provided for @checkedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in successfully!'**
  String get checkedIn;

  /// No description provided for @checkedOut.
  ///
  /// In en, this message translates to:
  /// **'Checked out successfully!'**
  String get checkedOut;

  /// No description provided for @myAvailability.
  ///
  /// In en, this message translates to:
  /// **'My Availability'**
  String get myAvailability;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @conflicts.
  ///
  /// In en, this message translates to:
  /// **'Conflicts'**
  String get conflicts;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @addAvailability.
  ///
  /// In en, this message translates to:
  /// **'Add Availability'**
  String get addAvailability;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @availabilityAdded.
  ///
  /// In en, this message translates to:
  /// **'Availability added successfully'**
  String get availabilityAdded;

  /// No description provided for @availabilityDeleted.
  ///
  /// In en, this message translates to:
  /// **'Availability deleted successfully'**
  String get availabilityDeleted;

  /// No description provided for @availabilityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Availability updated successfully'**
  String get availabilityUpdated;

  /// No description provided for @errorAddingAvailability.
  ///
  /// In en, this message translates to:
  /// **'Error adding availability'**
  String get errorAddingAvailability;

  /// No description provided for @errorDeletingAvailability.
  ///
  /// In en, this message translates to:
  /// **'Error deleting availability'**
  String get errorDeletingAvailability;

  /// No description provided for @errorUpdatingAvailability.
  ///
  /// In en, this message translates to:
  /// **'Error updating availability'**
  String get errorUpdatingAvailability;

  /// No description provided for @deleteAvailability.
  ///
  /// In en, this message translates to:
  /// **'Delete Availability'**
  String get deleteAvailability;

  /// No description provided for @deleteAvailabilityConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this availability?'**
  String get deleteAvailabilityConfirmation;

  /// No description provided for @availabilityDetails.
  ///
  /// In en, this message translates to:
  /// **'Availability Details'**
  String get availabilityDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @timeSlots.
  ///
  /// In en, this message translates to:
  /// **'Time Slots'**
  String get timeSlots;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeToNurseLife.
  ///
  /// In en, this message translates to:
  /// **'Welcome to NurseLife'**
  String get welcomeToNurseLife;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get createYourAccount;

  /// No description provided for @agreeToTermsAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get agreeToTermsAndPrivacy;

  /// No description provided for @pleaseAgreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the terms and privacy policy'**
  String get pleaseAgreeToTerms;

  /// No description provided for @passwordMustContainUpperLowerNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, and numbers'**
  String get passwordMustContainUpperLowerNumber;

  /// No description provided for @passwordAtLeastEightChars.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordAtLeastEightChars;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @firstNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'First name must be at least 2 characters'**
  String get firstNameTooShort;

  /// No description provided for @lastNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Last name must be at least 2 characters'**
  String get lastNameTooShort;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a verification code'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendVerificationCode;

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent!'**
  String get verificationCodeSent;

  /// No description provided for @verificationCodeSentDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to your email. Please check your inbox'**
  String get verificationCodeSentDescription;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @enterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to reset your password'**
  String get enterEmailToReset;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code from your email and your new password'**
  String get resetPasswordSubtitle;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @verificationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get verificationCodeHint;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordHint;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successful!'**
  String get passwordResetSuccess;

  /// No description provided for @passwordResetSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'You can now log in with your new password'**
  String get passwordResetSuccessDescription;

  /// No description provided for @invalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired verification code'**
  String get invalidVerificationCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Code resent successfully'**
  String get codeResent;

  /// No description provided for @pleaseEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code'**
  String get pleaseEnterVerificationCode;

  /// No description provided for @verificationCodeMustBeSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Verification code must be 6 digits'**
  String get verificationCodeMustBeSixDigits;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @completeProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Finish setting up your account to start finding shifts'**
  String get completeProfileSubtitle;

  /// No description provided for @registrationStepPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get registrationStepPersonalInfo;

  /// No description provided for @registrationStepProfessionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Professional Details'**
  String get registrationStepProfessionalDetails;

  /// No description provided for @registrationStepDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents & Verification'**
  String get registrationStepDocuments;

  /// No description provided for @registrationStepReview.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get registrationStepReview;

  /// No description provided for @stepComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get stepComplete;

  /// No description provided for @stepCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get stepCurrent;

  /// No description provided for @stepPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get stepPending;

  /// No description provided for @personalInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ll collect your personal details here'**
  String get personalInfoDescription;

  /// No description provided for @professionalDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your nursing experience'**
  String get professionalDetailsDescription;

  /// No description provided for @documentsVerification.
  ///
  /// In en, this message translates to:
  /// **'Documents & Verification'**
  String get documentsVerification;

  /// No description provided for @documentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload your professional documents'**
  String get documentsDescription;

  /// No description provided for @reviewAndSubmit.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get reviewAndSubmit;

  /// No description provided for @reviewDescription.
  ///
  /// In en, this message translates to:
  /// **'Review your information before submitting'**
  String get reviewDescription;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @stepPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'This step is under development and will be fully implemented soon.'**
  String get stepPlaceholder;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(Object current, Object total);

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String percentComplete(Object percent);

  /// No description provided for @professionalInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get professionalInformationTitle;

  /// No description provided for @professionalInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your nursing credentials and expertise'**
  String get professionalInformationSubtitle;

  /// No description provided for @nursingRegistrationNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Nursing Registration Number'**
  String get nursingRegistrationNumberLabel;

  /// No description provided for @nursingRegistrationNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Your official nursing registration number'**
  String get nursingRegistrationNumberHint;

  /// No description provided for @yearsOfExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsOfExperienceLabel;

  /// No description provided for @yearsOfExperienceHelper.
  ///
  /// In en, this message translates to:
  /// **'Total years of nursing experience'**
  String get yearsOfExperienceHelper;

  /// No description provided for @areasOfSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Areas of Specialization'**
  String get areasOfSpecialization;

  /// No description provided for @areasOfSpecializationHelper.
  ///
  /// In en, this message translates to:
  /// **'Select your areas of expertise (choose at least one)'**
  String get areasOfSpecializationHelper;

  /// No description provided for @professionalBioLabel.
  ///
  /// In en, this message translates to:
  /// **'Professional Bio'**
  String get professionalBioLabel;

  /// No description provided for @professionalBioHelper.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your professional background and expertise'**
  String get professionalBioHelper;

  /// No description provided for @characterCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/{max} characters'**
  String characterCount(Object current, Object max);

  /// No description provided for @specializationCriticalCare.
  ///
  /// In en, this message translates to:
  /// **'Critical Care'**
  String get specializationCriticalCare;

  /// No description provided for @specializationEmergencyMedicine.
  ///
  /// In en, this message translates to:
  /// **'Emergency Medicine'**
  String get specializationEmergencyMedicine;

  /// No description provided for @specializationPediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get specializationPediatrics;

  /// No description provided for @specializationOncology.
  ///
  /// In en, this message translates to:
  /// **'Oncology'**
  String get specializationOncology;

  /// No description provided for @specializationCardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get specializationCardiology;

  /// No description provided for @specializationOrthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get specializationOrthopedics;

  /// No description provided for @specializationMentalHealth.
  ///
  /// In en, this message translates to:
  /// **'Mental Health'**
  String get specializationMentalHealth;

  /// No description provided for @specializationGeriatrics.
  ///
  /// In en, this message translates to:
  /// **'Geriatrics'**
  String get specializationGeriatrics;

  /// No description provided for @specializationSurgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get specializationSurgery;

  /// No description provided for @specializationMaternity.
  ///
  /// In en, this message translates to:
  /// **'Maternity'**
  String get specializationMaternity;

  /// No description provided for @specializationICU.
  ///
  /// In en, this message translates to:
  /// **'ICU'**
  String get specializationICU;

  /// No description provided for @specializationGeneralMedicine.
  ///
  /// In en, this message translates to:
  /// **'General Medicine'**
  String get specializationGeneralMedicine;

  /// No description provided for @registrationNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Registration number is required'**
  String get registrationNumberRequired;

  /// No description provided for @registrationNumberTooShort.
  ///
  /// In en, this message translates to:
  /// **'Registration number must be at least 5 characters'**
  String get registrationNumberTooShort;

  /// No description provided for @yearsOfExperienceRequired.
  ///
  /// In en, this message translates to:
  /// **'Years of experience is required'**
  String get yearsOfExperienceRequired;

  /// No description provided for @yearsOfExperienceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number (0-50)'**
  String get yearsOfExperienceInvalid;

  /// No description provided for @specializationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one specialization'**
  String get specializationRequired;

  /// No description provided for @bioTooLong.
  ///
  /// In en, this message translates to:
  /// **'Bio cannot exceed 500 characters'**
  String get bioTooLong;

  /// No description provided for @savingData.
  ///
  /// In en, this message translates to:
  /// **'Saving your information...'**
  String get savingData;

  /// No description provided for @dataSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Information saved successfully!'**
  String get dataSavedSuccessfully;

  /// No description provided for @errorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Failed to save information. Please try again.'**
  String get errorSavingData;

  /// No description provided for @personalInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformationTitle;

  /// No description provided for @personalInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get personalInformationSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
