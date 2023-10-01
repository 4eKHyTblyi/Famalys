import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/bottom_nav_bar.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:famalys/pages/widgets/new.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final TabController _tabController2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController2 = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController2.dispose();
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
      drawer: MyDrawer(fio: global_fio),
      bottomNavigationBar: const MyBottomNavBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ClipRRect(
              child: Image(
                image: AssetImage('assets/profile_with_level.png'),
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Мария Ивановна',
                  style: HelperFunctions.h1Black,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.black12,
                    )),
              ],
            ),
            Text(
              '@maria_2444',
              style: HelperFunctions.pGrey,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '32 подписки',
                  style: HelperFunctions.pGrey,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '144 подписчика',
                  style: HelperFunctions.pGrey,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                """Semper faucibus bibendum odio cras tortor est. Ipsum vitae ut et id suspendisse diam. Ut in eget morbi id diam morbi. Elit etiam felis malesuada habitant lectus mattis ultricies fusce. Sed eu libero vel accumsan libero ac. Volutpat nam turpis facilisis nec. Quam mattis tincidunt bibendum convallis neque. Fusce mauris sed condimentum dolor quis ut.""",
                style: HelperFunctions.pGrey,
              ),
            ),
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
                              child: Image.asset('assets/images.png')),
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
                            height: 50, child: Image.asset('assets/like.png')),
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
                            height: 50,
                            child: Image.asset('assets/rating.png')),
                        Text(
                          'Рейтинг',
                          style: HelperFunctions.pGrey,
                        )
                      ],
                    ),
                  ),
                ]),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: TabBarView(
                  controller: _tabController,
                  children: [listOfHistories(), notes(), listOfHistories()]),
            ))
          ],
        ),
      ),
    );
  }

  Widget listOfHistories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: ListView(
            addSemanticIndexes: true,
            scrollDirection: Axis.horizontal,
            children: [
              HelperFunctions().profileHistory(),
              HelperFunctions().profileHistory(),
              HelperFunctions().profileHistory(),
              HelperFunctions().profileHistory(),
              HelperFunctions().profileHistory(),
            ],
          ),
        ),
        NewPost(
            name: "name",
            userName: "userName",
            photoUrl: "",
            userId: "userId",
            postId: "postId")
      ],
    );
  }

  Widget notes() {
    return TabBar(
      controller: _tabController2,
      tabs: [
        Tab(
          height: 300,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "Публикации",
              style: HelperFunctions.h1,
            ),
          ),
        ),
        Tab(
          height: 30,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "Статьи",
              style: HelperFunctions.h1,
            ),
          ),
        ),
        Tab(
          height: 30,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "Люди",
              style: HelperFunctions.h1,
            ),
          ),
        ),
        Tab(
          height: 30,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "Игры",
              style: HelperFunctions.h1,
            ),
          ),
        ),
        Tab(
          height: 30,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "Курсы",
              style: HelperFunctions.h1,
            ),
          ),
        ),
      ],
    );
  }
}
