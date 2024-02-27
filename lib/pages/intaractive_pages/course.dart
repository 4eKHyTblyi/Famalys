import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/undered_list.dart';
import 'package:flutter/material.dart';

///
class CourseInfo extends StatelessWidget {
  const CourseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
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
                'Курсы',
                style: HelperFunctions.pGrey,
              )
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Начни с себя', style: HelperFunctions.h1Black32),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text('Длительность курса: ', style: HelperFunctions.pGrey16),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: HelperFunctions.lightGrey,
                      ),
                      child: Text(HelperFunctions().days(3),
                          style: HelperFunctions.pWhite)),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Категории:',
                      style: HelperFunctions.pGrey16,
                    ),
                    HelperFunctions.widgetWithGradient('География', 30,
                        MediaQuery.of(context).size.width / 2, 3, 5),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Вы узнаете', style: HelperFunctions.h1Black26),
                  UnorderedList(const [
                    'Как понять себя, стать лучше и найти своё предназначение?',
                    'Как улучшить взаимоотношения с людьми?',
                    'Как стать увереннее в себе?',
                    "Lorem ipsum dolor...'",
                  ]),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Программа курса', style: HelperFunctions.h1Black26),
                    blocksList(5, context),
                  ],
                )),
          ])),
    );
  }
}

int selectedIndex = 0;

blocksList(
  int count,
  BuildContext context,
) {
  return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 50,
      child: ListView.builder(
          itemCount: count,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == selectedIndex) {
              return HelperFunctions.widgetWithGradient(
                'Блок $index',
                30,
                100,
                2,
                5,
              );
            } else {
              return GestureDetector(
                onTap: () {
                  selectedIndex = index;
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: HelperFunctions.lightGrey,
                  ),
                  child: Text(
                    '$index',
                    style: HelperFunctions.pGrey,
                  ),
                ),
              );
            }
            return Container(width: 100);
          }));
}

///
///
///
///
///
///
///
///
///
class CourseCreate extends StatefulWidget {
  const CourseCreate({super.key});

  @override
  State<CourseCreate> createState() => _CourseCreateState();
}

class _CourseCreateState extends State<CourseCreate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
