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
  user() async {
    myId = myUser!.uid;
    notifications_coll =
        notifications_coll.doc(myId).collection('notifications');
  }

  @override
  Widget build(BuildContext context) {
    user();
    var _switch = notifications_coll.doc('switch').snapshots();
    var _chats = notifications_coll.doc('chats').snapshots();
    var _messenger = notifications_coll.doc('messenger').snapshots();
    var _new_publication =
        notifications_coll.doc('new_publication').snapshots();
    var _comments = notifications_coll.doc('comments').snapshots();
    var _reactions = notifications_coll.doc('reactions').snapshots();
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Уведомления",
            style: HelperFunctions.h1,
          ),
          StreamBuilder(
              stream: _switch,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data('name'));
                return Text('data');
                //notificationCard(
                //snapshot.data['name'], snapshot.data['check']);
              }),
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
          ok = !ok;
        });
        print(ok);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(myId)
            .collection('notifications')
            .doc(id)
            .update({'check': ok});
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
