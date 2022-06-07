import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/repository/user_repository.dart';

part 'user_logout_state.dart';

class UserLogoutCubit extends Cubit<UserLogoutState> {
  final UserRepository userRepository;

  UserLogoutCubit(this.userRepository) : super(UserLogoutInitial());

  Future<String> logout() async {
    String returnValue = "";
    emit(UserLogoutLoading());
    await userRepository.logout().then((userLogoutObject) async {
      returnValue = "successful";
      emit(UserLogoutCompleted());
    });
    return returnValue;
  }
}
