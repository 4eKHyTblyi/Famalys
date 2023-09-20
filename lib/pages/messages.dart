import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/chat_page.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Сообщения',
              style: HelperFunctions.h1Black,
            ),
            HelperFunctions.searchInput(
                context, MediaQuery.of(context).size.width * 0.75),
            messagesList(1),
          ]),
        ));
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
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      subtitle: Container(
        padding: const EdgeInsets.only(right: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'last message',
              ),
            ),
            Text('00:00')
          ],
        ),
      ),
      title: const Text(
        "Username",
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset('assets/profile.png'),
      ),
      onTap: () async {
        nextScreen(
            context,
            ChatScreen(
                chatWithUsername: 'chatWithUsername',
                name: 'name',
                photoUrl: '',
                id: 'id',
                chatId: 'chatId'));
      },
      tileColor: Colors.white24,
      contentPadding: const EdgeInsets.all(5.0),
    );
  }
}
