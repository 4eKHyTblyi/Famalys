import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool one = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ElevatedButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              elevation: MaterialStatePropertyAll(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/back.png'),
              Text(
                'Назад',
                style: HelperFunctions.pGrey,
              )
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Text(
            "Уведомления",
            style: HelperFunctions.h1,
          ),
          CustomCheckbox(one)
        ]),
      ),
    );
  }
}

CustomCheckbox(bool check) {
  return TextButton(
    onPressed: () {
      check != check;
      print(1);
    },
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        splashFactory: NoSplash.splashFactory),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color.fromRGBO(212, 220, 254, 1),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: check
                ? const LinearGradient(colors: [
                    Color.fromRGBO(255, 166, 182, 1),
                    Color.fromRGBO(255, 232, 172, 1),
                  ])
                : LinearGradient(colors: [Colors.white, Colors.white])),
      ),
    ),
  );
}
