import 'package:flutter/cupertino.dart';

class Comments extends StatefulWidget {
  final List<CommentTemplate> comments;
  const Comments({required this.comments, super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CommentTemplate {
  String name = "";
  String userName = "";
  String photoUrl = "";
  String textOfComment = "";
  int countOfLikes = 0, countOfReports = 0;

  CommentTemplate(this.name, this.userName, this.photoUrl, this.textOfComment,
      this.countOfLikes, this.countOfReports);
}
