import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<bool> login() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null || !user.emailVerified) {
      return false;
    } else {
      return true;
    }
  }
}
