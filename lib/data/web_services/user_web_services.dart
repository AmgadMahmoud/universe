import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universe/data/models/user.dart';

class UserWebServices {
  UserWebServices();

  Future<String> login(String username, String password) async {
    String returnObject = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password)
          .then((userCredential) async {
        if (userCredential.user!.emailVerified) {
          returnObject = "success";
        } else {
          await userCredential.user
              ?.sendEmailVerification()
              .then((value) async {
            returnObject = "notVerified";
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      returnObject = e.code;
    }
    return returnObject;
  }

  Future<String> signup(UserData userData, String password) async {
    String returnObject = "";
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData.email,
        password: password,
      );
      await addUser(userData).then((value) async {
        await credential.user?.sendEmailVerification().then((value) {
          returnObject = "success";
        });
      });
    } on FirebaseAuthException catch (e) {
      returnObject = e.code;
    } catch (e) {
      returnObject = "error";
    }

    return returnObject;
  }

  addUser(UserData userData) async {
    await FirebaseFirestore.instance.collection("users").add({
      "userID": FirebaseAuth.instance.currentUser?.uid,
      "firstName": userData.firstName,
      "lastName": userData.lastName,
      "email": userData.email,
      "userName": userData.userName,
    });
  }

  Future<String> logout() async {
    String returnObject = "";
    await FirebaseAuth.instance.signOut().then((value) {
      returnObject = "completed";
    });
    return returnObject;
  }
}
