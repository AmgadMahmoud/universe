import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/repository/user_repository.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  final UserRepository userRepository;

  UserLoginCubit(this.userRepository) : super(UserLoginInitial());

  Future<String> login(String userName, String password) async {
    String returnValue = "";
    emit(UserLoginLoading());

    await userRepository.login(userName, password).then((userObject) async {
      returnValue = userObject;
      if (userObject == "success") {
        emit(UserLoginCompleted());
      } else {
        emit(UserLoginError());
      }
    });
    return returnValue;
  }
}
