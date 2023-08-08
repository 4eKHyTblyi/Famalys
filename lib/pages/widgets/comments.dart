import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final List<CommentTemplate> comments;
  const Comments({required this.comments, super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey, //change your color here
        ),
      ),
      body: ListView.builder(
          itemCount: widget.comments.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: widget.comments[index].photoUrl == ""
                        ? Image.asset("assets/profile.png")
                        : Image.network(widget.comments[index].photoUrl),
                    title: Text(widget.comments[index].name),
                    subtitle: Text(widget.comments[index].userName),
                    trailing:
                        Text(widget.comments[index].timeCreate.toString()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(widget.comments[index].textOfComment),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class CommentTemplate {
  String name = "";
  String userName = "";
  String photoUrl = "";
  String textOfComment = "";
  String timeCreate = "";
  int countOfLikes = 0, countOfReports = 0;

  CommentTemplate(this.name, this.userName, this.photoUrl, this.textOfComment,
      this.countOfLikes, this.countOfReports, this.timeCreate);
}
