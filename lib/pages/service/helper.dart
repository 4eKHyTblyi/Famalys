import 'package:famalys/pages/widgets/message_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  static TextStyle h1Black = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);

  static TextStyle h2 = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static TextStyle pGrey = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static TextStyle pGrey16 = const TextStyle(
      color: Color.fromRGBO(125, 132, 168, 1),
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static TextStyle pBlack = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);

  static EdgeInsets paddingH15V10 =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

  static Widget inputTemplate(
      String label, String hintText, BuildContext context) {
    TextEditingController? password;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 242, 255, 1),
          borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        controller: password,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
            hintText: hintText,
            fillColor: const Color.fromRGBO(239, 242, 255, 1),
            border: InputBorder.none),
      ),
    );
  }

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(100),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [
      Color.fromRGBO(255, 166, 182, 1),
      Color.fromRGBO(255, 232, 172, 1),
      Color.fromRGBO(193, 237, 152, 1),
      Color.fromRGBO(166, 228, 255, 1),
    ]),
    borderRadius: BorderRadius.circular(100),
  );

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
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  static Widget buttomImageTemplate(
      Image image, BuildContext context, Function onPressed) {
    return IconButton(
        splashRadius: 25,
        onPressed: () {
          onPressed;
        },
        icon: image);
  }

  static Widget buttonTemplate(BuildContext context, String text) {
    return Container(
      alignment: Alignment.center,
      height: 44,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/Acuarela2.png'), fit: BoxFit.cover),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 166, 182, 1),
          Color.fromRGBO(255, 232, 172, 1),
          Color.fromRGBO(193, 237, 152, 1),
          Color.fromRGBO(166, 228, 255, 1),
        ]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: pGrey16,
      ),
    );
  }

  //DATETIME RUS FORMAT
  static datetimeFormat(DateTime dateTime) {
    String day = dateTime.day < 10 ? "0${dateTime.day}" : "${dateTime.day}";
    String month =
        dateTime.month < 10 ? "0${dateTime.month}" : "${dateTime.month}";
    String year = dateTime.year < 10 ? "0${dateTime.year}" : "${dateTime.year}";

    String hour = dateTime.hour < 10 ? "0${dateTime.hour}" : "${dateTime.hour}";
    String minutes =
        dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}";
    return Text("$day.$month.$year  $hour.$minutes");
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

  static Widget searchInput(BuildContext context, double width) {
    return Row(
      children: [
        SizedBox(
            width: width,
            child: HelperFunctions.inputTemplate("label", "Поиск", context)),
        HelperFunctions.buttomImageTemplate(
            Image.asset('assets/search.png'), context, () {
          print(1);
        })
      ],
    );
  }

  static Widget tab(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: pGrey16,
      ),
    );
  }

  article() {
    return SafeArea(
      top: true,
      child: Container(
        width: 194,
        height: 273,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/Frame 547.png',
            ).image,
          ),
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        child: Align(
          alignment: AlignmentDirectional(-1.00, 0.00),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'Роль дедушки во взрослении внуков',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'Автор А.А.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebookMessenger,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.ios_share,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    Text(
                      '203',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

showDrawer(context) {
  Scaffold.of(context).openDrawer();
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

// MESSAGES TEMPLATE 
