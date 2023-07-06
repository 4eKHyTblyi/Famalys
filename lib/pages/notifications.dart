import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool one = true;

  var myUser = FirebaseAuth.instance.currentUser;
  String myId = "";
  CollectionReference notifications_coll =
      FirebaseFirestore.instance.collection('users');
  user() {
    myId = myUser!.uid;
    notifications_coll =
        notifications_coll.doc(myId).collection('notifications');
  }

  List<Notification> notifications = [
    Notification("Включить звук уведомлений", true),
    Notification("Чаты", true),
    Notification("Мессенджер", true),
    Notification("Новые публикации", true),
    Notification("Ответы и комментарии", true),
    Notification("Реакции", true),
  ];

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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Уведомления",
            style: HelperFunctions.h1,
          ),
          StreamBuilder(
              stream: notifications_coll.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data!.size == 0) {
                    for (int i = 0; i < notifications.length; i++) {
                      notifications_coll.add({
                        'name': notifications[i].name,
                        'check': notifications[i].check
                      });
                    }

                    return CircularProgressIndicator();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Категории уведомлений",
                          style: HelperFunctions.pGrey,
                        ),
                        SizedBox(
                            height: 400,
                            child: ListView.builder(
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  return notificationCard(
                                      snapshot.data!.docs[index]['name'],
                                      snapshot.data!.docs[index]['check'],
                                      snapshot.data!.docs[index].id);
                                })),
                      ],
                    );
                  }
                } else {
                  return Text('error');
                }
              })
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
      onPressed: () {
        setState(() {
          ok = !ok;

          FirebaseFirestore.instance
              .collection('users')
              .doc(myId)
              .collection('notifications')
              .doc(id)
              .update({'check': ok});
        });
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
                  : LinearGradient(colors: [Colors.white, Colors.white])),
        ),
      ),
    );
  }
}

class Notification {
  String name = "";
  bool check = true;

  Notification(name, check) {
    this.name = name;
    this.check = check;
  }
}
