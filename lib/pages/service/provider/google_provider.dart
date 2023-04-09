import 'package:famalys/pages/service/database.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../home_page.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    HelperFunctions.saveUserLoggedInStatus(true);

    print(googleUser.email);

    await DataBaseService().addUserData(googleUser.photoUrl,
        '@${googleUser.email.toLowerCase()}', googleUser.displayName);

    nextScreen(context, HomePage());

    notifyListeners();
  }
}
