import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      bottomNavigationBar: MyBottomNavBar(),
      bottomSheet: Text("DADADADADAAAADADADA"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            HelperFunctions.searchInput(
                context, MediaQuery.of(context).size.width * 0.8),
            SizedBox(
              width: 300,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: HelperFunctions.tab("text")),
                  ElevatedButton(
                      onPressed: () {}, child: HelperFunctions.tab("text")),
                  ElevatedButton(
                      onPressed: () {}, child: HelperFunctions.tab("text")),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
