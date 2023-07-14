import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_page.dart';
import 'auth_service.dart';

class HelperFunctions {
  //keys
  static String userIdKey = "USERKEY";
  static String photoUrl = "PHOTOURL";
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String displayNameKey = "USERDISPLAYNAMEKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";

//Styles
  static TextStyle h1 = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 20,
      fontWeight: FontWeight.w500);

  static TextStyle h2 = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static TextStyle pGrey = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static TextStyle pBlack = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);

  static EdgeInsets paddingH15V10 =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

  static Widget passwordInput(String label, bool hide, BuildContext context) {
    TextEditingController? password;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            obscuringCharacter: '*',
            obscureText: hide,
            controller: password,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  hide != hide;
                },
              ),
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
              hintText: 'Пароль',
              fillColor: const Color.fromRGBO(239, 242, 255, 1),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
        )
      ],
    );
  }

  // saving the data to SF

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }
}

void goOutApp(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Аккаунт"),
          content: const Text("Вы уверены что хотите выйти?"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
          ],
        );
      });
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(String value, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    backgroundColor: color,
  ));
}

Route createRoute(Widget Function() createPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => createPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
