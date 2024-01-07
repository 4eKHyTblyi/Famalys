import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/account.dart';
import 'package:famalys/pages/notifications.dart';
import 'package:famalys/pages/security.dart';
import 'package:famalys/pages/service/auth_service.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String fio = global_fio;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ListTile(
                    title: Text(
                      fio,
                      style: HelperFunctions.h1,
                    ),
                    subtitle: Text(
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
                      style: HelperFunctions.pGrey,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        global_avatar,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 10,
                    onTap: () async {
                      nextScreen(
                          context,
                          ProfilePage(
                            fio: global_fio,
                          ));
                    },
                    leading: Image.asset(
                      'assets/account.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Аккаунт",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 10,
                    onTap: () async {
                      nextScreen(context, NotificationsPage());
                    },
                    leading: Image.asset(
                      'assets/notifications.png',
                      width: 21,
                      height: 21,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Уведомления",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 10,
                    onTap: () async {
                      nextScreen(context, SecurityPage());
                    },
                    leading: Image.asset(
                      'assets/lock.png',
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Безопасность",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    minLeadingWidth: 10,
                    onTap: () async {},
                    leading: Image.asset(
                      'assets/help 1.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Поддержка",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    minLeadingWidth: 10,
                    onTap: () async {},
                    leading: Image.asset(
                      'assets/users.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Добро",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    minLeadingWidth: 10,
                    onTap: () async {},
                    leading: Image.asset(
                      'assets/users.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      "Администраторам",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: 50,
                    decoration: HelperFunctions().kGradientBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: HelperFunctions().kInnerDecoration,
                        child: TextButton(
                          onPressed: () {
                            AuthService().signOut();
                            nextScreen(context, LoginPage());
                          },
                          child: Text(
                            "Выйти из аккаунта",
                            style: HelperFunctions.pBlack,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                  widthFactor: 100,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '© «Families», 2023',
                      style: HelperFunctions.pGrey,
                    ),
                  ))
            ]),
      ),
    );
  }
}
