part of 'user_login_cubit.dart';

@immutable
abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginCompleted extends UserLoginState {
  UserLoginCompleted();
}

class UserLoginLoading extends UserLoginState {
  UserLoginLoading();
}

class UserLoginError extends UserLoginState {
  UserLoginError();
}
