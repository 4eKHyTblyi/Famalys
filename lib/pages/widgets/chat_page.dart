import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/widgets/audio_controller.dart';
import 'package:famalys/pages/widgets/record_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:record_mp3/record_mp3.dart';
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

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
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
          "text": message,
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
                              message: ds["text"],
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

  //List<AssetEntity> images = [];

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
    getAndSetMessages();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  // Future<void> getImagesFromGallery() async {
  //   final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
  //   print(paths.first);
  // }

  static const List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.gif_box)),
    Tab(
      icon: Icon(Icons.image),
    ),
  ];

  late TabController _tabController;

  final images = ValueNotifier<List<XFile?>>([]);

  @override
  Widget build(BuildContext context) {
    Future uploadImage(image) async {
      if (image.isNotEmpty) {
        for (var i = 0; i < image.length; i++) {
          Reference storageRef = FirebaseStorage.instance.ref();
          var file = storageRef.child("${widget.id}/${DateTime.now()}");
          await file.putFile(File(image[i]!.path));

          var url = await file.getDownloadURL();

          addMessage(true, url);
        }
      } else {
        addMessage(true, '');
      }
    }

    void _show(BuildContext ctx) {
      showModalBottomSheet(
          elevation: 10,
          backgroundColor: Colors.white,
          context: ctx,
          builder: (ctx) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: HelperFunctions.inputTemplate(
                          'label',
                          'Введите сообщение',
                          context,
                          messageTextEdittingController),
                    ),
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 40,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.gif_box_outlined,
                            size: 40,
                          )),
                    ),
                    CircleAvatar(
                      radius: 40,
                      child: IconButton(
                          onPressed: () async {
                            List<XFile?> image =
                                await ImagePicker().pickMultiImage(
                              imageQuality: 50,
                            );

                            setState(() {
                              images.value = image;
                            });

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                            size: 40,
                          )),
                    ),
                  ])
                ],
              ),
            );
          });
    }

    var mainColor = Theme.of(context).primaryColor;
    late String recordFilePath;
    AudioController audioController = Get.put(AudioController());
    int i = 0;

    Future<bool> checkPermission() async {
      if (!await Permission.microphone.isGranted) {
        PermissionStatus status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          return false;
        }
      }
      return true;
    }

    Future<String> getFilePath() async {
      Directory storageDirectory = await getApplicationDocumentsDirectory();
      String sdPath =
          "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
      var d = Directory(sdPath);
      if (!d.existsSync()) {
        d.createSync(recursive: true);
      }
      return "$sdPath/test_${i++}.mp3";
    }

    void startRecord() async {
      bool hasPermission = await checkPermission();
      if (hasPermission) {
        recordFilePath = await getFilePath();
        RecordMp3.instance.start(recordFilePath, (type) {
          setState(() {});
        });
      } else {}
      setState(() {});
    }

    void stopRecord() async {
      bool stop = RecordMp3.instance.stop();
      audioController.end.value = DateTime.now();
      audioController.calcDuration();
      var ap = AudioPlayer();
      await ap.play(AssetSource("Notification.mp3"));
      ap.onPlayerComplete.listen((a) {});
      if (stop) {
        audioController.isRecording.value = false;
        audioController.isSending.value = true;
        //await uploadAudio();
      }
    }

    AudioPlayer audioPlayer = AudioPlayer();

    Widget _audio({
      required String message,
      required bool isCurrentUser,
      required int index,
      required String time,
      required String duration,
    }) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isCurrentUser ? mainColor : mainColor.withOpacity(0.18),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                audioController.onPressedPlayButton(index, message);
                // changeProg(duration: duration);
              },
              onSecondaryTap: () {
                audioPlayer.stop();
                //   audioController.completedPercentage.value = 0.0;
              },
              child: Obx(
                () => (audioController.isRecordPlaying &&
                        audioController.currentId == index)
                    ? Icon(
                        Icons.cancel,
                        color: isCurrentUser ? Colors.white : mainColor,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: isCurrentUser ? Colors.white : mainColor,
                      ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.white : mainColor,
                        ),
                        value: (audioController.isRecordPlaying &&
                                audioController.currentId == index)
                            ? audioController.completedPercentage.value
                            : audioController.totalDuration.value.toDouble(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              duration,
              style: TextStyle(
                  fontSize: 12,
                  color: isCurrentUser ? Colors.white : mainColor),
            ),
          ],
        ),
      );
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
        alignment: Alignment.bottomCenter,
        children: [
          chatMessages(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 170,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder(
              valueListenable: images,
              builder: (ctx, v, widget) {
                print(images.value.length);
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.value.length,
                    itemBuilder: (ctx, i) {
                      return Stack(
                        alignment: Alignment.topRight,
                        textDirection: TextDirection.rtl,
                        clipBehavior: Clip.none,
                        children: [
                          Image.file(
                            File(images.value[i]!.path),
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: -20,
                            top: -20,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    images.value.removeAt(i);
                                  });
                                },
                                icon: Icon(Icons.cancel_outlined)),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
          Container(
            height: 70,
            alignment: Alignment.bottomCenter,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          _show(context);
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
                    GestureDetector(
                        onLongPressStart: (details) async {
                          startRecord();
                        },
                        onLongPressEnd: (details) async {
                          stopRecord();
                        },
                        child: (Icon(Icons.mic_rounded))),
                    Transform.rotate(
                      angle: 44.78,
                      child: GestureDetector(
                          onTap: () {
                            uploadImage(images.value);
                            images.value = [];
                          },
                          child: Image.asset(
                            'assets/msg_icons.png',
                          )),
                    )
                  ],
                ),
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
