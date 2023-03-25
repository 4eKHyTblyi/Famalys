import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      HelperFunctions.saveUserLoggedInStatus(true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return ('Пользователь не найден.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return ('Неверный пароль.');
      }
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.currentUser!.updateDisplayName('name');
      HelperFunctions.saveUserLoggedInStatus(true);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('Пароль слишком слабый.');
      } else if (e.code == 'email-already-in-use') {
        return ('Аккаунт уже существует.');
      }
    } catch (e) {
      print(e);
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
