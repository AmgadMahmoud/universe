part of 'user_signup_cubit.dart';

@immutable
abstract class UserSignupState {}

class UserSignupInitial extends UserSignupState {}

class UserSignupCompleted extends UserSignupState {
  UserSignupCompleted();
}

class UserSignupLoading extends UserSignupState {
  UserSignupLoading();
}

class UserSignupError extends UserSignupState {
  UserSignupError();
}
