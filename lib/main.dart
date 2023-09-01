import 'package:famalys/global/global_vars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/auth/login_page.dart';
import 'pages/home_page.dart';
import 'pages/service/auth_service.dart';
import 'pages/service/helper.dart';
import 'pages/service/provider/google_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:figma_to_flutter/figma_to_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

void initNotifications(SharedPreferences sf) {
  SWITCH = sf.getBool("SWITCH")!;
  MESSENGER = sf.getBool("MESSENGER")!;
  COMMENTS = sf.getBool("COMMENTS")!;
  PUBLICATION = sf.getBool("PUBLICATION")!;
  CHATS = sf.getBool("CHATS")!;
  REACTIONS = sf.getBool("REACTIONS")!;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          home: _isSignedIn ? const HomePage() : const LoginPage(),
        ),
      );
}
