import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../global/global_vars.dart';
import 'messages.dart';

class NewPublicationPage extends StatefulWidget {
  const NewPublicationPage({super.key});

  @override
  State<NewPublicationPage> createState() => _NewPublicationPageState();
}

class _NewPublicationPageState extends State<NewPublicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: MyDrawer(fio: global_fio),
      bottomNavigationBar: const MyBottomNavBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: HelperFunctions().kGradientBoxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: HelperFunctions().kInnerDecoration,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Начать прямой эфир",
                    style: HelperFunctions.pBlack,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 400,
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 125,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                    ),
                    child: HelperFunctions.tab('Пост'),
                  ),
                ),
                SizedBox(
                  width: 125,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                    ),
                    child: HelperFunctions.tab('История'),
                  ),
                ),
                SizedBox(
                  width: 125,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                    ),
                    child: HelperFunctions.tab('Клип'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, top: 20),
            child: Text(
              "Новый пост",
              style: HelperFunctions.h1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(239, 242, 255, 1),
                borderRadius: BorderRadius.circular(25)),
            child: TextFormField(
              maxLines: 10,
              minLines: 7,
              decoration: const InputDecoration(
                  hintText: 'Текст',
                  hintStyle: TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
                  fillColor: Color.fromRGBO(239, 242, 255, 1),
                  border: InputBorder.none),
            ),
          ),
          HelperFunctions.inputTemplate('', 'О вложений', context)
        ]),
      ),
    );
  }
}
