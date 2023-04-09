import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  showDrawer(context) {
    Scaffold.of(context).openDrawer();
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

  @override
  void initState() {
    super.initState();
    getFio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
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
              onPressed: () {}, icon: Image.asset('assets/msg_icons.png'))
        ],
      ),
      drawer: MyDrawer(
        fio: fio,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: kGradientBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: kInnerDecoration,
                        child: Container(
                          child: Center(child: Icon(Icons.add)),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                          height: 55,
                          width: 55,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 5,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 65,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return lentaNovostey();
                        },
                        itemCount: 10,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  lentaNovostey() {
    return Row(
      children: [
        Container(
          decoration: kGradientBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: kInnerDecoration,
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
                height: 55,
                width: 55,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
