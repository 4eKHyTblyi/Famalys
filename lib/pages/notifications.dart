import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool one = true;

  bool LOCAL_SWITCH = true;
  bool LOCAL_COMMENTS = true;
  bool LOCAL_REACTIONS = true;
  bool LOCAL_PUBLICATION = true;
  bool LOCAL_CHATS = true;
  bool LOCAL_MESSENGER = true;

  var myUser = FirebaseAuth.instance.currentUser;
  String myId = "";
  CollectionReference notifications_coll =
      FirebaseFirestore.instance.collection('users');
  user() {
    myId = myUser!.uid;
    notifications_coll =
        notifications_coll.doc(myId).collection('notifications');
  }

  @override
  void initState() {
    super.initState();
    if (sharedPreferences?.getBool("SWITCH") != null) {
      LOCAL_SWITCH = sharedPreferences!.getBool("SWITCH")!;
      LOCAL_COMMENTS = sharedPreferences!.getBool("COMMENTS")!;
      LOCAL_REACTIONS = sharedPreferences!.getBool("REACTIONS")!;
      LOCAL_PUBLICATION = sharedPreferences!.getBool("PUBLICATION")!;
      LOCAL_CHATS = sharedPreferences!.getBool("CHATS")!;
      LOCAL_MESSENGER = sharedPreferences!.getBool("MESSENGER")!;
    }
  }

  @override
  Widget build(BuildContext context) {
    user();
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
          onPressed: () {
            sharedPreferences!.setBool("SWITCH", LOCAL_SWITCH);
            sharedPreferences!.setBool("COMMENTS", LOCAL_COMMENTS);
            sharedPreferences!.setBool("REACTIONS", LOCAL_REACTIONS);
            sharedPreferences!.setBool("PUBLICATION", LOCAL_PUBLICATION);
            sharedPreferences!.setBool("CHATS", LOCAL_CHATS);
            sharedPreferences!.setBool("MESSENGER", LOCAL_MESSENGER);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Уведомления",
            style: HelperFunctions.h1,
          ),
          notificationCard("Включить звук уведомлений", LOCAL_SWITCH, "SWITCH"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Категории уведомлений",
            style: HelperFunctions.h2,
          ),
          notificationCard("Чаты", LOCAL_COMMENTS, "COMMENTS"),
          notificationCard("Мессенджер", LOCAL_REACTIONS, "REACTIONS"),
          notificationCard(
              "Новые публикации", LOCAL_PUBLICATION, "PUBLICATION"),
          notificationCard("Ответы и комментарии", LOCAL_CHATS, "CHATS"),
          notificationCard("Реакции", LOCAL_MESSENGER, "MESSENGER"),
        ]),
      ),
    );
  }

  notificationCard(name, check, [id]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: HelperFunctions.pBlack),
        customCheckbox(check, id),
      ],
    );
  }

  customCheckbox(bool check, [id]) {
    bool ok = check;
    return TextButton(
      onPressed: () async {
        setState(() {
          switch (id) {
            case "SWITCH":
              LOCAL_SWITCH = !ok;
            case "COMMENTS":
              LOCAL_COMMENTS = !ok;
            case "REACTIONS":
              LOCAL_REACTIONS = !ok;
            case "PUBLICATION":
              LOCAL_PUBLICATION = !ok;
            case "CHATS":
              LOCAL_CHATS = !ok;
            case "MESSENGER":
              LOCAL_MESSENGER = !ok;
          }
        });
        print(check);
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          splashFactory: NoSplash.splashFactory),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(212, 220, 254, 1),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: check
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(255, 166, 182, 1),
                      Color.fromRGBO(255, 232, 172, 1),
                    ])
                  : const LinearGradient(colors: [Colors.white, Colors.white])),
        ),
      ),
    );
  }
}

class Notification {
  String name = "";
  bool check = true;
  String id = "";

  Notification(name, check, id) {
    this.name = name;
    this.check = check;
    this.id = id;
  }
}
