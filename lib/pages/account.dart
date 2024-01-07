import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/global/global_vars.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String fio;
  const ProfilePage({super.key, required this.fio});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fio_ctrl = TextEditingController();
  TextEditingController nickName = TextEditingController(text: global_nickname);
  TextEditingController tel = TextEditingController(text: global_phone);
  TextEditingController description =
      TextEditingController(text: global_description);
  TextEditingController email = TextEditingController(text: global_email);

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fio_ctrl = TextEditingController(text: widget.fio);
  }

  @override
  Widget build(BuildContext context) {
    showDrawer(context) {
      Scaffold.of(context).openDrawer();
    }

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Аккаунт',
                  style: HelperFunctions.h1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                    fit: BoxFit.fitWidth, // otherwise the logo will be tiny
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image(
                            width: 107,
                            height: 107,
                            fit: BoxFit.cover,
                            color: Colors.grey.withOpacity(0.9),
                            colorBlendMode: BlendMode.modulate,
                            image: NetworkImage(global_avatar),
                          ),
                          Positioned(
                            left: 30,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () async {
                                var image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                var storage = FirebaseStorage.instance;
                                var storage_image =
                                    storage.ref().child(image!.path);
                                await storage_image.putFile(File(image.path));
                                global_avatar =
                                    await storage_image.getDownloadURL();
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({'avatar': global_avatar});
                              },
                              iconSize: 30,
                            ),
                          ),
                        ])),
              ),
              FIO(widget.fio),
              const SizedBox(
                height: 15,
              ),
              Nickname(),
              const SizedBox(
                height: 15,
              ),
              Description(),
              const SizedBox(
                height: 15,
              ),
              Phone(),
              const SizedBox(
                height: 15,
              ),
              Email(),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(global_avatar);
                    Navigator.pop(context);
                    global_description = description.text;
                    global_nickname = nickName.text;
                    global_email = email.text;
                    global_phone = tel.text;
                    global_fio = fio_ctrl.text;
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'fio': fio_ctrl.text,
                      'nickname': nickName.text,
                      'description': description.text,
                      'phone': tel.text,
                      'email': email.text
                    });
                  },
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/Acuarela2.png'),
                          fit: BoxFit.cover),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(255, 166, 182, 1),
                        Color.fromRGBO(255, 232, 172, 1),
                        Color.fromRGBO(193, 237, 152, 1),
                        Color.fromRGBO(166, 228, 255, 1),
                      ]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      'Сохранить изменения',
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
    );
  }

  FIO(String fio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Имя и фамилия",
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: fio_ctrl,
            decoration: InputDecoration(
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
              hintText: fio,
              fillColor: const Color.fromRGBO(239, 242, 255, 1),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Nickname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Имя пользователя",
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: nickName,
            decoration: InputDecoration(
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
              hintText: FirebaseAuth.instance.currentUser!.displayName,
              fillColor: const Color.fromRGBO(239, 242, 255, 1),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Описание",
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: description,
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Color.fromRGBO(125, 132, 168, 1),
                  overflow: TextOverflow.clip),
              hintText: global_description,
              fillColor: Color.fromRGBO(239, 242, 255, 1),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Phone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Номер телефона (информация видна только вам)",
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: tel,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
              hintText: global_phone,
              fillColor: Color.fromRGBO(239, 242, 255, 1),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Почта (информация видна только вам)",
            style: HelperFunctions.pGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 242, 255, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
              hintText: global_email,
              fillColor: const Color.fromRGBO(239, 242, 255, 1),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
