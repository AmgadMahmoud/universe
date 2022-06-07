import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/models/user.dart';
import 'package:universe/data/repository/user_repository.dart';

part 'user_signup_state.dart';

class UserSignupCubit extends Cubit<UserSignupState> {
  final UserRepository userRepository;

  UserSignupCubit(this.userRepository) : super(UserSignupInitial());

  Future<String> signup(UserData user, String password) async {
    String returnValue = "";
    emit(UserSignupLoading());

    await userRepository.signup(user, password).then((userObject) async {
      returnValue = userObject;
      if (userObject == "success") {
        emit(UserSignupCompleted());
      } else {
        emit(UserSignupError());
      }
    });
    return returnValue;
  }
}
