import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String fio;
  ProfilePage({super.key, required this.fio});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    showDrawer(context) {
      Scaffold.of(context).openDrawer();
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ElevatedButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              elevation: MaterialStatePropertyAll(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/back.png'),
              Text(
                'Назад',
                style: HelperFunctions.pGrey,
              )
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Аккаунт',
                style: HelperFunctions.h1,
              ),
              Image.network(
                FirebaseAuth.instance.currentUser!.photoURL.toString(),
                scale: 0.7,
                fit: BoxFit.cover,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth, // otherwise the logo will be tiny
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Image(
                      image: NetworkImage(FirebaseAuth
                          .instance.currentUser!.photoURL
                          .toString()),
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.android),
                        color: Colors.white,
                        onPressed: () {},
                        iconSize: 50,
                      ),
                    ),
                  ]))
            ],
          )),
    );
  }
}
