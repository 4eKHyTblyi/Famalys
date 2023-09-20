import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/messages.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:famalys/pages/widgets/histories.dart';
import 'package:famalys/pages/widgets/new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fio = '';

  getFio() async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      fio = doc.get('fio');
    });
  }

  var list = FirebaseFirestore.instance
      .collection('histories')
      .withConverter<HistoryTemplate>(
          fromFirestore: (snapshots, _) =>
              HistoryTemplate.fromJson(snapshots.data()!),
          toFirestore: (history, _) => history.toJson());

  @override
  void initState() {
    super.initState();
    getFio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                showDrawer(context);
              },
              icon: Image.asset('assets/DRAWER_BURGER.png'));
        }),
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/LOGO_IN_APPBAR.png'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const ListMessages());
              },
              icon: Image.asset('assets/msg_icons.png'))
        ],
      ),
      drawer: MyDrawer(
        fio: fio,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 65,
                child: Histories(histories: list),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: Column(
                children: [
                  const Row(
                    children: [
                      VerticalDivider(
                        width: 5,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  NewPost(
                      name: "name",
                      userName: "userName",
                      photoUrl: "",
                      userId: "userId",
                      postId: "postId")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  listOfNews() {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return NewPost(
              name: "name",
              userName: "userName",
              photoUrl: "",
              userId: "userId",
              postId: "postId");
        });
  }
}
