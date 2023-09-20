import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
