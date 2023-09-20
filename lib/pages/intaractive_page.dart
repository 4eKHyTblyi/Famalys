import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class IntaractivePage extends StatefulWidget {
  const IntaractivePage({super.key});

  @override
  State<IntaractivePage> createState() => _IntaractivePageState();
}

class _IntaractivePageState extends State<IntaractivePage> {
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
    );
  }
}
