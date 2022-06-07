import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get pleaseEnterYourEmail {
    return Intl.message('Please enter your email',
        name: 'pleaseEnterYourEmail');
  }

  String get pleaseEnterCorrectEmail {
    return Intl.message('Please enter correct email',
        name: 'pleaseEnterCorrectEmail');
  }

  String get emailDoesNotFound {
    return Intl.message('Email does n\'t found', name: 'emailDoesNotFound');
  }

  String get pleaseEnterYourUserName {
    return Intl.message('Please enter your username',
        name: 'pleaseEnterYourUserName');
  }

  String get pleaseEnterYourPassword {
    return Intl.message('Please enter your password',
        name: 'pleaseEnterYourPassword');
  }

  String get pleaseConfirmYourPassword {
    return Intl.message('Please confirm your password',
        name: 'pleaseConfirmYourPassword');
  }

  String get pleaseEnterCorrectUserName {
    return Intl.message('Please enter correct username',
        name: 'pleaseEnterCorrectUserName');
  }

  String get userNameDoesNotFound {
    return Intl.message('Username does n\'t found',
        name: 'userNameDoesNotFound');
  }

  String get password {
    return Intl.message('Password', name: 'password');
  }

  String get confirmPassword {
    return Intl.message('Confirm password', name: 'confirmPassword');
  }

  String get passwordIsNotCorrect {
    return Intl.message('Password is n\'t correct',
        name: 'passwordIsNotCorrect');
  }

  String get emailOrPasswordIsNotCorrect {
    return Intl.message('Email or password is n\'t correct',
        name: 'emailOrPasswordIsNotCorrect');
  }

  String get passwordDoesNotMatch {
    return Intl.message('Password does n\'t match',
        name: 'passwordDoesNotMatch');
  }

  String get appVersion {
    return Intl.message('Version 1.0.0', name: 'appVersion');
  }

  String get firstName {
    return Intl.message('First name', name: 'firstName');
  }

  String get lastName {
    return Intl.message('Last name', name: 'lastName');
  }

  String get pleaseEnterYourFirstName {
    return Intl.message('Please enter your first name',
        name: 'pleaseEnterYourFirstName');
  }

  String get pleaseEnterYourLastName {
    return Intl.message('Please enter your last name',
        name: 'pleaseEnterYourLastName');
  }

  String get signUp {
    return Intl.message('Sign up', name: 'signUp');
  }

  String get userName {
    return Intl.message('User name', name: 'userName');
  }

  String get forgotPasswordWithQuestionMark {
    return Intl.message('Forgot password?',
        name: 'forgotPasswordWithQuestionMark');
  }

  String get forgotPassword {
    return Intl.message('Forgot password', name: 'forgotPassword');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get ifYouDoNotHaveAccountSignUp {
    return Intl.message('If you do n\'t have account sign up',
        name: 'ifYouDoNotHaveAccountSignUp');
  }

  String get or {
    return Intl.message('Or', name: 'or');
  }

  String get createNewAccount {
    return Intl.message('Create new account', name: 'createNewAccount');
  }

  String get changeLanguage {
    return Intl.message('Change language', name: 'changeLanguage');
  }

  String get logout {
    return Intl.message('Logout', name: 'logout');
  }

  String get pleaseWait {
    return Intl.message('Please wait', name: 'pleaseWait');
  }

  String get areYouSureOfExit {
    return Intl.message('Are you sure of Exit?', name: 'areYouSureOfExit');
  }

  String get yes {
    return Intl.message('Yes', name: 'yes');
  }

  String get no {
    return Intl.message('No', name: 'no');
  }

  String get ifYouDoNotHaveAnAccountSignUp {
    return Intl.message('If you don\'t have an account, sign up',
        name: 'ifYouDoNotHaveAnAccountSignUp');
  }

  String get home {
    return Intl.message('Home', name: 'home');
  }

  String get myAccount {
    return Intl.message('My account', name: 'myAccount');
  }

  String get saved {
    return Intl.message('Saved', name: 'saved');
  }

  String get uploadImage {
    return Intl.message('Upload image', name: 'uploadImage');
  }

  String get publish {
    return Intl.message('Publish', name: 'publish');
  }

  String get ignore {
    return Intl.message('Ignore', name: 'ignore');
  }

  String get writeACommentAboutThePhoto {
    return Intl.message('Write a comment about the photo',
        name: 'writeACommentAboutThePhoto');
  }

  String get thePasswordProvidedIsTooWeak {
    return Intl.message('The password provided is too weak',
        name: 'thePasswordProvidedIsTooWeak');
  }

  String get theAccountAlreadyExistsForThatEmail {
    return Intl.message('The account already exists for that email',
        name: 'theAccountAlreadyExistsForThatEmail');
  }

  String get invalidCredentials {
    return Intl.message('Invalid credentials', name: 'invalidCredentials');
  }

  String get errorConnectingWithServer {
    return Intl.message('Error connecting with server',
        name: 'errorConnectingWithServer');
  }

  String get errorConnectingToTheInternet {
    return Intl.message('Error connecting to the internet',
        name: 'errorConnectingToTheInternet');
  }

  String get accountCreatedSuccessfullyAnEmailHasBeenSentToVerifyYourAccount {
    return Intl.message(
        'Account created successfully, an email has been sent to verify your account',
        name:
            'accountCreatedSuccessfullyAnEmailHasBeenSentToVerifyYourAccount');
  }

  String
      get accountNotVerifiedPleaseFollowInstructionsOnEmailToVerifyYourAccount {
    return Intl.message(
        'Account not verified, please follow instructions on email to verify your account',
        name:
            'accountNotVerifiedPleaseFollowInstructionsOnEmailToVerifyYourAccount');
  }

  String get loading {
    return Intl.message('Loading', name: 'loading');
  }

  String get pressRetryToTryAgain {
    return Intl.message('Press retry to try again', name: 'pressRetryToTryAgain');
  }

  String get retry {
    return Intl.message('Retry', name: 'retry');
  }

  String get youAreOfflinePleaseCheckYourInternetConnection {
    return Intl.message('You are offline, Please check your internet connection', name: 'youAreOfflinePleaseCheckYourInternetConnection');
  }

  String get noPostsFound {
    return Intl.message('No posts found', name: 'noPostsFound');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<_DefaultCupertinoLocalizations>(
          _DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;

  _DefaultCupertinoLocalizations(this.locale);
}
