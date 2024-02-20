import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          ElevatedButton(
              onPressed: () {},
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: HelperFunctions.buttonTemplate(context, 'Добавить курс')),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {},
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: HelperFunctions.buttonTemplate(context, 'Добавить игру')),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {},
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child:
                  HelperFunctions.buttonTemplate(context, 'Добавить статью')),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {},
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: HelperFunctions.buttonTemplate(context, 'Курсы')),
        ]),
      ),
    );
  }
}
