// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginButton => 'Login';

  @override
  String get emailLabel => 'Institutional Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Name';

  @override
  String get registerPrompt => 'Don\'t have an account? Sign up';

  @override
  String get errorInvalidCredentials => 'Invalid username or password.';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get errorShortPassword =>
      'Password should be at least 6 characters long';

  @override
  String get signUpScreen => 'Sign Up';

  @override
  String get errorNoName => 'Please enter your name';

  @override
  String get driverRoleTitle => 'I want to offer rides';

  @override
  String get driverRoleSubtitle => 'Check if you also want to act as a driver';

  @override
  String get registerSuccessMessage =>
      'Account created! Please check your email';

  @override
  String get registerButton => 'Sign Up';

  @override
  String get errorEmailNotVerified =>
      'Account not activated. Please check your email.';

  @override
  String get errorEmailAlreadyRegistered => 'This email is already registered.';

  @override
  String get errorServer => 'Server connection error. Please try again later.';

  @override
  String get errorGeneric => 'An unexpected error occurred.';
}
