import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:random_string/random_string.dart';

import '../service/database_service.dart';
import '../service/helper.dart';
import 'message_tile.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name, photoUrl, id, chatId;
  final List<CameraDescription> cameras;
  const ChatScreen(
      {Key? key,
      required this.chatWithUsername,
      required this.name,
      required this.photoUrl,
      required this.id,
      required this.chatId,
      required this.cameras})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageId = "";
  Stream? messageStream;
  late String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEdittingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = HelperFunctions().getDisplayName().toString();
    myProfilePic = HelperFunctions().getUserProfileUrl().toString();
    myUserName = HelperFunctions().getUserName().toString();
    myEmail = HelperFunctions().getUserEmail().toString();
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked, String photoUrl) async {
    if (messageTextEdittingController.text != "" || photoUrl != "") {
      // QuerySnapshot querySnap = await FirebaseFirestore.instance
      //     .collection('users')
      //     .where('name', isEqualTo: widget.chatWithUsername)
      //     .get();
      // String chatWith = querySnap.docs[0]['chatWith'];
      // bool isUserInChat = chatWith == FirebaseAuth.instance.currentUser!.uid;

      // isUserInChat
      //     ? null
      //     : DatabaseService().updateUnreadMessageCount(widget.chatId);
      String message = messageTextEdittingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap;

      if (photoUrl == "") {
        messageInfoMap = {
          "text": message,
          "sender": FirebaseAuth.instance.currentUser!.uid,
          "time": lastMessageTs,
          "isRead": false
        };
      } else {
        messageInfoMap = {
          "image": photoUrl,
          "sender": FirebaseAuth.instance.currentUser!.uid,
          "time": lastMessageTs,
          "isRead": false
        };
      }

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseService()
          .addMessage(widget.chatId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": FirebaseAuth.instance.currentUser!.displayName,
          "lastMessageSendByID": FirebaseAuth.instance.currentUser!.uid,
        };

        DatabaseService()
            .updateLastMessageSend(widget.chatId, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEdittingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
      messageId = "";

      // DocumentSnapshot doc = await FirebaseFirestore.instance
      //     .collection('TOKENS')
      //     .doc(widget.id)
      //     .get();
      // DocumentSnapshot snap = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(widget.id)
      //     .get();
      // String token = doc.get('token');
      // String name = snap.get('fullName');
      // print(token);

      // !isUserInChat
      //     ? NotificationsService().sendPushMessage(token, message, name, 4,
      //         FirebaseAuth.instance.currentUser!.photoURL, 'dcscscs')
      //     : null;
    }
  }

  Widget chatMessageTile(String message, bool sendByMe, bool isRead) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  bottomRight: sendByMe
                      ? const Radius.circular(0)
                      : const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: sendByMe
                      ? const Radius.circular(24)
                      : const Radius.circular(0),
                ),
                color: sendByMe ? Colors.orange : Colors.blue.shade400,
              ),
              padding: EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: sendByMe ? 0 : 24,
                  right: sendByMe ? 24 : 0),
              child: Container(
                constraints:
                    BoxConstraints(minWidth: 50, maxWidth: size.width / 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      maxLines: 100,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return snapshot.hasData
              ? snapshot.data.docs.length != 0
                  ? ListView.builder(
                      padding: const EdgeInsets.only(bottom: 70, top: 16),
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        ds.id;
                        if (ds["sender"] !=
                            FirebaseAuth.instance.currentUser!.uid) {
                          FirebaseFirestore.instance
                              .collection('chats')
                              .doc(widget.chatId)
                              .collection('messages')
                              .doc(ds.id)
                              .update({'isRead': true});
                        }

                        var userName = '';

                        if (ds["sender"] ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          userName = widget.name;
                        } else {
                          userName = widget.chatWithUsername;
                        }

                        Map<String, dynamic> data =
                            ds.data() as Map<String, dynamic>;

                        if (data["image"] != null) {
                          return MessageTile(
                              sender: ds["sender"],
                              name: userName,
                              message: "",
                              sentByMe:
                                  FirebaseAuth.instance.currentUser!.uid ==
                                      ds["sender"],
                              isRead: ds["isRead"],
                              photoUrl: ds["image"]);
                        } else {
                          return MessageTile(
                              sender: ds["sender"],
                              name: userName,
                              message: ds["text"],
                              sentByMe:
                                  FirebaseAuth.instance.currentUser!.uid ==
                                      ds["sender"],
                              isRead: ds["isRead"],
                              photoUrl: "");
                        }
                      })
                  : const Center(
                      child: Text(
                        'Сообщения отсутствуют.',
                        textAlign: TextAlign.center,
                      ),
                    )
              : const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  getAndSetMessages() async {
    messageStream = await DatabaseService().getChatRoomMessages(widget.chatId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  chatWith_Update(String id) async {
    String myId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'chatWith': id});
    DocumentSnapshot chat = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get();

    var chatSnapshot =
        FirebaseFirestore.instance.collection('chats').doc(widget.chatId);

    String lastMessageSendBy = "ds";

    if (lastMessageSendBy != FirebaseAuth.instance.currentUser!.displayName) {
      chatSnapshot.update({
        'unreadMessage': 0,
      });
    }
  }

  Future<bool> outOfChat() async {
    String myId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'chatWith': ''});

    return true;
  }

  List<AssetEntityImage> assets = [];

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
    getAndSetMessages();
  }

  // Future<void> getImagesFromGallery(
  //   required int maxCount,
  //   required Request requestType,
  // ) async {
  //   StorageImages? storageImages;
  //   try {
  //     storageImages = await GalleryImages().getStorageImages();
  //     print(storageImages!.images!.length);
  //     storageImages.images!.clear();
  //   } catch (error) {
  //     print(12);
  //     debugPrint(error.toString());
  //   }

  //   if (!mounted) return;

  //   setState(() {
  //     _storageImages = storageImages;
  //   });
  // }
  List _storageImages = [];

  @override
  Widget build(BuildContext context) {
    void _show(BuildContext ctx) {
      showModalBottomSheet(
          elevation: 10,
          backgroundColor: Colors.white,
          context: ctx,
          builder: (ctx) => _storageImages != null
              ? GridView.builder(
                  itemCount: _storageImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(_storageImages[index].path),
                            fit: BoxFit.fill));
                  },
                )
              : const Center(child: CircularProgressIndicator()));
      // Container(
      //       color: Colors.transparent,
      //       alignment: Alignment.center,
      //       child: Column(children: [
      //         SizedBox(
      //           height: 60,
      //           child: Row(
      //             children: [
      //               ElevatedButton(
      //                 style: const ButtonStyle(
      //                     padding:
      //                         MaterialStatePropertyAll(EdgeInsets.all(15)),
      //                     backgroundColor:
      //                         MaterialStatePropertyAll(Colors.transparent),
      //                     elevation: MaterialStatePropertyAll(0)),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Image.asset('assets/back.png'),
      //                   ],
      //                 ),
      //                 onPressed: () => Navigator.of(context).pop(),
      //               ),
      //             ],
      //           ),
      //         ),
      //         controller.value.isInitialized
      //             ? Stack(
      //                 children: [
      //                   SizedBox(
      //                     height: 100,
      //                     child: CameraPreview(
      //                       controller,
      //                       child: SizedBox(
      //                         height: 100,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               )
      //             : CircularProgressIndicator()
      //       ]),
      //     ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              elevation: MaterialStatePropertyAll(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/back.png'),
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: FloatingActionButton(
                      onPressed: () async {},
                      child: widget.photoUrl != ''
                          ? Image.network(
                              widget.photoUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 45,
                            )
                          : Image.asset('assets/profile.png')),
                )),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.chatWithUsername,
              style: HelperFunctions.h1Black,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        _show(context);
                        // List<XFile?> image = await ImagePicker().pickMultiImage(
                        //   imageQuality: 50,
                        // );

                        // if (image.isNotEmpty) {
                        //   for (var i = 0; i < image.length; i++) {
                        //     Reference storageRef =
                        //         FirebaseStorage.instance.ref();
                        //     var file = storageRef
                        //         .child("${widget.id}/${DateTime.now()}");
                        //     await file.putFile(File(image[i]!.path));

                        //     var url = await file.getDownloadURL();

                        //     addMessage(false, url);
                        //   }
                        // }
                      },
                      child: Image.asset(
                        'assets/icons.png',
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: HelperFunctions.inputTemplate(
                        'label',
                        'Введите сообщение',
                        context,
                        messageTextEdittingController),
                  )),
                  Transform.rotate(
                    angle: 44.78,
                    child: GestureDetector(
                        onTap: () {
                          addMessage(true, '');
                        },
                        child: Image.asset(
                          'assets/msg_icons.png',
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePicture() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SimpleDialogOption(onPressed: () async {
              Navigator.of(context).pop();
            })
          ]);
        });
  }
}
