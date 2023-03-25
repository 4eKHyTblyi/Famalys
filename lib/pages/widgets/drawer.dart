import 'package:famalys/pages/service/auth_service.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 60),
        child: Column(children: [
          ListTile(
            title: Text(
              'Мария Иванова',
              style: HelperFunctions.h1,
            ),
            subtitle: Text(
              '@maria_2444',
              style: HelperFunctions.pGrey,
            ),
            leading: Image.network(
                FirebaseAuth.instance.currentUser!.photoURL.toString()),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Выйти"),
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
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
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
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Image.asset(
              'assets/settings.png',
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
            title: const Text(
              "Выйти",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}
