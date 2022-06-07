import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent = Function(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  get localeName => 'en';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "pleaseEnterYourEmail":
            MessageLookupByLibrary.simpleMessage("Please enter your email"),
        "pleaseEnterCorrectEmail":
            MessageLookupByLibrary.simpleMessage("Please enter correct email"),
        "emailDoesNotFound":
            MessageLookupByLibrary.simpleMessage("Email does n't found"),
        "pleaseEnterYourUserName":
            MessageLookupByLibrary.simpleMessage("Please enter your username"),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
            "Please confirm your password"),
        "pleaseEnterCorrectUserName": MessageLookupByLibrary.simpleMessage(
            "Please enter correct username"),
        "userNameDoesNotFound":
            MessageLookupByLibrary.simpleMessage("Username does n't found"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "passwordIsNotCorrect":
            MessageLookupByLibrary.simpleMessage("Password is n't correct"),
        "emailOrPasswordIsNotCorrect": MessageLookupByLibrary.simpleMessage(
            "Email or password is n't correct'"),
        "passwordDoesNotMatch":
            MessageLookupByLibrary.simpleMessage("Password does n't match"),
        "appVersion": MessageLookupByLibrary.simpleMessage("Version 1.0.0"),
        "firstName": MessageLookupByLibrary.simpleMessage("First name"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
        "pleaseEnterYourFirstName": MessageLookupByLibrary.simpleMessage(
            "Please enter your first name"),
        "pleaseEnterYourLastName":
            MessageLookupByLibrary.simpleMessage("Please enter your last name"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "userName": MessageLookupByLibrary.simpleMessage("User name"),
        "forgotPasswordWithQuestionMark":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "ifYouDoNotHaveAccountSignUp": MessageLookupByLibrary.simpleMessage(
            "If you do n't have account sign up"),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "createNewAccount":
            MessageLookupByLibrary.simpleMessage("Create new account"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change language"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage("Please wait"),
        "areYouSureOfExit":
            MessageLookupByLibrary.simpleMessage("Are you sure of Exit?"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "ifYouDoNotHaveAnAccountSignUp": MessageLookupByLibrary.simpleMessage(
            "If you don\'t have an account, sign up"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "myAccount": MessageLookupByLibrary.simpleMessage("My account"),
        "saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Upload image"),
        "publish": MessageLookupByLibrary.simpleMessage("Publish"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignore"),
        "writeACommentAboutThePhoto": MessageLookupByLibrary.simpleMessage(
            "Write a comment about the photo"),
        "thePasswordProvidedIsTooWeak": MessageLookupByLibrary.simpleMessage(
            "The password provided is too weak"),
        "theAccountAlreadyExistsForThatEmail":
            MessageLookupByLibrary.simpleMessage(
                "The account already exists for that email"),
        "invalidCredentials":
            MessageLookupByLibrary.simpleMessage("Invalid credentials"),
        "errorConnectingWithServer": MessageLookupByLibrary.simpleMessage(
            "Error connecting with server"),
        "errorConnectingToTheInternet": MessageLookupByLibrary.simpleMessage(
            "Error connecting to the internet"),
        "accountCreatedSuccessfullyAnEmailHasBeenSentToVerifyYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "Account created successfully, an email has been sent to verify your account"),
        "accountNotVerifiedPleaseFollowInstructionsOnEmailToVerifyYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "Account not verified, please follow instructions on email to verify your account"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "pressRetryToTryAgain":
            MessageLookupByLibrary.simpleMessage("Press retry to try again"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "youAreOfflinePleaseCheckYourInternetConnection":
            MessageLookupByLibrary.simpleMessage(
                "You are offline, Please check your internet connection"),
        "noPostsFound": MessageLookupByLibrary.simpleMessage("No posts found"),
      };
}
