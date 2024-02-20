import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String photoUrl;
  final String sender;
  final String name;
  final bool sentByMe;
  final bool isRead;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.photoUrl,
      required this.sender,
      required this.sentByMe,
      required this.isRead,
      required this.name})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = BoxDecoration(
        borderRadius: widget.sentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
        image: widget.sentByMe
            ? const DecorationImage(
                image: AssetImage('assets/msg_back.png'), fit: BoxFit.cover)
            : null,
        gradient: widget.sentByMe
            ? const LinearGradient(colors: [
                Color.fromRGBO(255, 166, 182, 1),
                Color.fromRGBO(255, 232, 172, 1),
              ])
            : LinearGradient(colors: [
                Color.fromRGBO(212, 220, 254, 1),
                Color.fromRGBO(212, 220, 254, 1)
              ]));

    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: widget.sentByMe ? 0 : 24,
            right: widget.sentByMe ? 24 : 0),
        alignment:
            widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: widget.photoUrl != ""
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                constraints: BoxConstraints(maxWidth: size.width * 0.5),
                margin: widget.sentByMe
                    ? const EdgeInsets.only(left: 30)
                    : const EdgeInsets.only(right: 30),
                decoration: boxDecoration,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      height: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(widget.message,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                widget.photoUrl,
                                height: 230,
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            backgroundBlendMode: BlendMode.multiply,
                            color: Colors.grey.shade500),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "22:22",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.7),
                margin: widget.sentByMe
                    ? const EdgeInsets.only(left: 30)
                    : const EdgeInsets.only(right: 30),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 20, right: 20),
                decoration: boxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   widget.name.toUpperCase(),
                    //   textAlign: TextAlign.start,
                    //   style: const TextStyle(
                    //       fontSize: 13,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //       letterSpacing: -0.5),
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(widget.message,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black)),
                        ),
                        widget.sentByMe
                            ? const SizedBox(
                                width: 10,
                              )
                            : const SizedBox(),
                        widget.sentByMe
                            ? widget.isRead
                                ? const FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 15,
                                    color: Colors.greenAccent,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 15,
                                    color: Colors.grey,
                                  )
                            : const SizedBox(),
                      ],
                    )
                    // widget.isRead
                    //     ? const FaIcon(FontAwesomeIcons.check)
                    //     : const FaIcon(FontAwesomeIcons.check),
                  ],
                ),
              ));
  }
}
