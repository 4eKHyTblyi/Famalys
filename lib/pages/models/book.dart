import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  String title;
  String author;
  String description;
  String authorAvatarUrl;
  DateTime datePublished;
  int likes;
  int views;

  BookPage(
      {super.key,
      required this.title,
      required this.author,
      required this.description,
      required this.authorAvatarUrl,
      required this.datePublished,
      required this.likes,
      required this.views});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: []),
    ));
  }
}
