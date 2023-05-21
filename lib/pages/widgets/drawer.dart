import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/account.dart';
import 'package:famalys/pages/service/auth_service.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';

class MyDrawer extends StatefulWidget {
  String fio;
  MyDrawer({super.key, required this.fio});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
                      widget.fio,
                      style: HelperFunctions.h1,
                    ),
                    subtitle: Text(
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
                      style: HelperFunctions.pGrey,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(FirebaseAuth
                          .instance.currentUser!.photoURL
                          .toString()),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 10,
                    onTap: () async {
                      nextScreen(
                          context,
                          ProfilePage(
                            fio: widget.fio,
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
                    onTap: () async {},
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
                    onTap: () async {},
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
