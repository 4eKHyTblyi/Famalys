import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/material.dart';

class ListMessages extends StatefulWidget {
  const ListMessages({super.key});

  @override
  State<ListMessages> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
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
        body: Column(children: [
          messagesList(3),
        ]));
  }

  messagesList(int length) {
    if (length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return chatTile("Ashly_02", "message", "21:12", "");
            }),
      );
    } else {
      return Container();
    }
  }

  chatTile(String nick, String message, String time, String photoUrl) {
    return Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/profile.png"),
          Column(
            children: [
              Text(nick),
              Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(message), Text(time)],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
