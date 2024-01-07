import 'package:famalys/pages/service/database.dart';
import 'package:famalys/pages/service/database_service.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class NewChat extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  const NewChat({super.key, required this.users});

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
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
      body: ListView.builder(
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text(widget.users[index]['fio']),
              subtitle: Text(
                widget.users[index]['name'],
                style: HelperFunctions.pGrey,
              ),
              onTap: () {},
              trailing: IconButton(
                onPressed: () async {
                  String chatId = randomAlpha(10);
                  List users = [
                    widget.users[index]['uid'],
                    FirebaseAuth.instance.currentUser!.uid
                  ];
                  await DatabaseService().addChat(users, chatId);

                  if (mounted) {
                    nextScreen(
                        context,
                        ChatScreen(
                            chatWithUsername: widget.users[index]['name'],
                            name: widget.users[index]['fio'],
                            photoUrl: widget.users[index]['avatar'],
                            id: widget.users[index]['uid'],
                            chatId: chatId,
                            cameras: const []));
                  }
                },
                icon: const ImageIcon(AssetImage("assets/chat.png")),
              ),
              leading: widget.users[index]['avatar'] != null
                  ? widget.users[index]['avatar'] == ""
                      ? Image.asset("assets/profile.png")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(widget.users[index]['avatar']),
                        )
                  : Image.asset("assets/profile.png"),
            ));
          }),
    );
  }
}
