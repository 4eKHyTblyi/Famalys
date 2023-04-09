import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar>
    with TickerProviderStateMixin {
  final bool _badges = false;
  Map<int, dynamic> listOfBadges = {};
  int index = 4;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 4,
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar.builder(
      count: 5,
      controller: tabController,
      onTap: (index) {
        tabController.index = 4;
        setState(() {
          _index = index;
        });
        _index = index;
      },
      itemBuilder: _Builder(),
      backgroundColor: const Color.fromRGBO(239, 242, 255, 1),
    );
  }
}

class _Builder extends DelegateBuilder {
  final List _list0 = [
    Image.asset('assets/bottom_menu/active/home.png'),
    Image.asset('assets/bottom_menu/disable/search.png'),
    Image.asset('assets/bottom_menu/disable/add.png'),
    Image.asset('assets/bottom_menu/disable/profile.png'),
    Image.asset('assets/bottom_menu/disable/services.png'),
  ];

  final List _list1 = [
    Image.asset('assets/bottom_menu/disable/home.png'),
    Image.asset('assets/bottom_menu/active/search.png'),
    Image.asset('assets/bottom_menu/disable/add.png'),
    Image.asset('assets/bottom_menu/disable/profile.png'),
    Image.asset('assets/bottom_menu/disable/services.png'),
  ];

  final List _list2 = [
    Image.asset('assets/bottom_menu/disable/home.png'),
    Image.asset('assets/bottom_menu/disable/search.png'),
    Image.asset('assets/bottom_menu/active/add.png'),
    Image.asset('assets/bottom_menu/disable/profile.png'),
    Image.asset('assets/bottom_menu/disable/services.png'),
  ];

  final List _list3 = [
    Image.asset('assets/bottom_menu/disable/home.png'),
    Image.asset('assets/bottom_menu/disable/search.png'),
    Image.asset('assets/bottom_menu/disable/add.png'),
    Image.asset('assets/bottom_menu/active/profile.png'),
    Image.asset('assets/bottom_menu/disable/services.png'),
  ];

  final List _list4 = [
    Image.asset('assets/bottom_menu/disable/home.png'),
    Image.asset('assets/bottom_menu/disable/search.png'),
    Image.asset('assets/bottom_menu/disable/add.png'),
    Image.asset('assets/bottom_menu/disable/profile.png'),
    Image.asset('assets/bottom_menu/active/services.png'),
  ];
  @override
  Widget build(BuildContext context, int index, bool active) {
    if (_index == 0) {
      return _list0[index];
    } else {
      if (_index == 1) {
        return _list1[index];
      } else {
        if (_index == 2) {
          return _list2[index];
        } else {
          if (_index == 3) {
            return _list3[index];
          } else {
            return _list4[index];
          }
        }
      }
    }
  }
}

int _index = 0;
