part of 'user_logout_cubit.dart';

@immutable
abstract class UserLogoutState {}

class UserLogoutInitial extends UserLogoutState {}

class UserLogoutCompleted extends UserLogoutState {
  UserLogoutCompleted();
}

class UserLogoutLoading extends UserLogoutState {
  UserLogoutLoading();
}

class UserLogoutError extends UserLogoutState {
  UserLogoutError();
}
