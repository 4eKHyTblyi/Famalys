import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/service/database_service.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/chat_page.dart';
import 'package:famalys/pages/widgets/new_chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMessages extends StatefulWidget {
  const ListMessages({super.key});

  @override
  State<ListMessages> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  Stream? chats;
  getChats() async {
    chats = await DatabaseService().getChatRooms();
  }

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                final usersCollection = FirebaseFirestore.instance
                    .collection('users')
                    .where('uid',
                        isNotEqualTo: FirebaseAuth.instance.currentUser!.uid);
                final usersSnapshot = await usersCollection.get();
                final users =
                    usersSnapshot.docs.map((doc) => doc.data()).toList();

                final chatsCollection = FirebaseFirestore.instance
                    .collection('chats')
                    .where('users',
                        arrayContains: FirebaseAuth.instance.currentUser!.uid);
                final chatsSnapshot = await chatsCollection.get();
                final chats =
                    chatsSnapshot.docs.map((doc) => doc.data()).toList();

                List<Map<String, dynamic>> usersWithoutChats = [];
                for (var user in users) {
                  bool hasChat = chats.any((chat) {
                    return chat['users'].contains(user['uid']);
                  });

                  if (!hasChat) {
                    usersWithoutChats.add(user);
                  }
                }

                if (mounted) {
                  nextScreen(
                      context,
                      NewChat(
                        users: usersWithoutChats,
                      ));
                }
              },
              icon: Image.asset('assets/plus.png'),
            )
          ],
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
                context, MediaQuery.of(context).size.width * 0.75, search),
            messagesList(),
          ]),
        ));
  }

  messagesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data!.docs.isEmpty) {
            print(snapshot.data!.docs.length);
            return const Center(
              child: Text('Нет сообщений'),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String chatId = snapshot.data!.docs[index].id;
                  String lastMessage =
                      snapshot.data!.docs[index]['lastMessage'];
                  String time = snapshot.data!.docs[index]['lastMessageSendTs']
                      .toString();
                  var users = snapshot.data!.docs[index]['users'];
                  var other_user_id =
                      users[0] == FirebaseAuth.instance.currentUser!.uid
                          ? users[1]
                          : users[0];
                  var other_user = FirebaseFirestore.instance
                      .collection('users')
                      .doc(other_user_id)
                      .snapshots();
                  return StreamBuilder(
                      stream: other_user,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var value = snapshot.data;
                          return chatTile(value?.get('fio'), lastMessage,
                              'time', value?.get('avatar'), chatId);
                        }
                      });
                },
                itemCount: snapshot.data!.docs.length,
              ),
            );
          }
        }
      },
    );
  }

  chatTile(String nick, String message, String time, String photoUrl,
      String chatId) {
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
      title: Text(
        nick.toString(),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(photoUrl.toString()),
      ),
      onTap: () async {
        String myName = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.get('fio'));
        List<CameraDescription> cameras = List.empty(growable: true);
        cameras = await availableCameras();
        if (context.mounted) {
          nextScreen(
              context,
              ChatScreen(
                  chatWithUsername: nick.toString(),
                  name: myName,
                  photoUrl: photoUrl.toString(),
                  id: 'id',
                  chatId: chatId,
                  cameras: cameras));
        }
      },
      tileColor: Colors.white24,
      contentPadding: const EdgeInsets.all(5.0),
    );
  }
}
