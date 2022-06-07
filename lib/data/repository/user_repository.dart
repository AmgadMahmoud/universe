import 'package:universe/data/models/user.dart';
import 'package:universe/data/web_services/user_web_services.dart';

class UserRepository {
  final UserWebServices userWebServices;

  UserRepository(this.userWebServices);

  Future<dynamic> login(String username, String password) async {
    final loginData = await userWebServices.login(username, password);
    return loginData;
  }

  Future<dynamic> signup(UserData userData, String password) async {
    final signupData = await userWebServices.signup(userData, password);
    return signupData;
  }

  Future<dynamic> logout() async {
    final logoutData = await userWebServices.logout();
    return logoutData;
  }
}
