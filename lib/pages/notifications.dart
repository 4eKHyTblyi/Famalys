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
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: GFCheckbox(
                type: GFCheckboxType.custom,
                activeBgColor: GFColors.SECONDARY,
                onChanged: (value) {
                  setState(() {
                    one = value;
                  });
                },
                value: one),
          ),
          Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              value: one,
              onChanged: (value) {
                setState(() {
                  one = value ?? false;
                });
              })
        ]),
      ),
    );
  }
}
