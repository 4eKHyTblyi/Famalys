import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class IntaractivePage extends StatefulWidget {
  const IntaractivePage({super.key});

  @override
  State<IntaractivePage> createState() => _IntaractivePageState();
}

class _IntaractivePageState extends State<IntaractivePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: const MyBottomNavBar(),
      drawer: MyDrawer(fio: global_fio),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            TabBar(
                indicatorColor: Colors.transparent,
                controller: _tabController,
                tabs: [
                  Tab(
                      height: 70,
                      child: Column(
                        children: [
                          SizedBox(
                              height: 50,
                              child: Image.asset('assets/courses.png')),
                          Text(
                            'Альбом',
                            style: HelperFunctions.pGrey,
                          )
                        ],
                      )),
                  Tab(
                    height: 70,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 50, child: Image.asset('assets/ball.png')),
                        Text(
                          'Заметки',
                          style: HelperFunctions.pGrey,
                        )
                      ],
                    ),
                  ),
                  Tab(
                    height: 70,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 50, child: Image.asset('assets/book.png')),
                        Text(
                          'Рейтинг',
                          style: HelperFunctions.pGrey,
                        )
                      ],
                    ),
                  ),
                  Tab(
                    height: 70,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 50, child: Image.asset('assets/chat.png')),
                        Text(
                          'Рейтинг',
                          style: HelperFunctions.pGrey,
                        )
                      ],
                    ),
                  ),
                ]),
            Container(
                height: 1000,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(controller: _tabController, children: [
                  library(),
                  library(),
                  library(),
                  library(),
                ]))
          ]),
        ),
      ),
    );
  }

  Widget library() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Библиотека',
          style: HelperFunctions.h1Black26,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            'Мы собрали для вас самые интересные и полезные статьи и публикации от экспертов в различных областях, врачей и психологов. Наиболее интересующие вас статьи вы можете сохранять у себя в заметках или делиться ими со своими друзьями. '),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: HelperFunctions.searchInput(
              context, MediaQuery.of(context).size.width * 0.82),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: HelperFunctions().article2(true),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: HelperFunctions().article2(false),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: HelperFunctions().article2(true),
        ),
      ],
    );
  }
}
