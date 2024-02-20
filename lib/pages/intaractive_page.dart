import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class IntaractivePage extends StatefulWidget {
  final int index;
  const IntaractivePage({required this.index, super.key});

  @override
  State<IntaractivePage> createState() => _IntaractivePageState();
}

class _IntaractivePageState extends State<IntaractivePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.index);
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
      drawer: const MyDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              courses(),
              games(),
              library(),
              library(),
            ]),
          )
        ]),
      ),
    );
  }

  Widget games() {
    TextEditingController search = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Игры',
          style: HelperFunctions.h1Black26,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Lorem ipsum dolor sit amet consectetur. Tincidunt sollicitudin eget pellentesque est at viverra neque.'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: HelperFunctions.searchInput(
              context, MediaQuery.of(context).size.width * 0.82, search),
        ),

        for (int i = 0; i < 3; i++) articles(i, isGame: true),

        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 3,
        //   width: MediaQuery.of(context).size.width,
        //   child: ListView.builder(
        //       itemCount: 3,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 10),
        //           child: HelperFunctions().article2(
        //               true, context, 'Тут должен быть текст', 'Автор', '0'),
        //         );
        //       }),
        // )
      ]),
    );
  }

  Widget library() {
    TextEditingController search = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Библиотека',
          style: HelperFunctions.h1Black26,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Мы собрали для вас самые интересные и полезные статьи и публикации от экспертов в различных областях, врачей и психологов. Наиболее интересующие вас статьи вы можете сохранять у себя в заметках или делиться ими со своими друзьями. '),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: HelperFunctions.searchInput(
              context, MediaQuery.of(context).size.width * 0.82, search),
        ),

        for (int i = 0; i < 3; i++) articles(i),

        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 3,
        //   width: MediaQuery.of(context).size.width,
        //   child: ListView.builder(
        //       itemCount: 3,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 10),
        //           child: HelperFunctions().article2(
        //               true, context, 'Тут должен быть текст', 'Автор', '0'),
        //         );
        //       }),
        // )
      ]),
    );
  }

  Widget articles(int count, {bool? isGame}) {
    return Column(children: [
      const SizedBox(
        height: 30,
      ),
      if (isGame != null && isGame)
        HelperFunctions().game('text', context, 'photoUrl', 202, 1, 1)
      else
        HelperFunctions()
            .article2(true, context, 'Тут должен быть текст', 'Автор', '0')
    ]);
  }

  Widget course(int count) {
    return coursesTemplate(
        context, 'Тут должен быть текст', 'Тут должен быть текст', 'Автор', 1);
  }

  Widget courses() {
    TextEditingController search = TextEditingController();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Курсы',
          style: HelperFunctions.h1Black26,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Проходите квесты, чтобы найти для себя новую и интересную информацию. Развивайтесь и учитесь  вместе со своей семьёй.'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: HelperFunctions.searchInput(
              context, MediaQuery.of(context).size.width * 0.82, search),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.614,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                return GridTile(child: course(index));
              }),
        )
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 3,
        //   width: MediaQuery.of(context).size.width,
        //   child: ListView.builder(
        //       itemCount: 3,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 10),
        //           child: HelperFunctions().article2(
        //               true, context, 'Тут должен быть текст', 'Автор', '0'),
        //         );
        //       }),
        // )
      ]),
    );
  }
}
