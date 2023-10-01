import 'package:famalys/pages/service/helper.dart';
import 'package:famalys/pages/widgets/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  String name;
  String userName;
  String photoUrl;
  String userId;
  String postId;
  NewPost(
      {required this.name,
      required this.userName,
      required this.photoUrl,
      required this.userId,
      required this.postId,
      super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool maxLinesMore = false;
  bool liked = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 900,
      constraints: const BoxConstraints(maxHeight: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //PROFILE
          Row(
            children: [
              widget.photoUrl != ""
                  ? const Image(image: NetworkImage(""))
                  : SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset("assets/profile.png")),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: HelperFunctions.pBlack,
                  ),
                  Text(
                    widget.name,
                    style: HelperFunctions.pGrey,
                  ),
                ],
              )
            ],
          ),

          //CONTENT
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: Image.asset(
                "assets/logo2 2.png",
                fit: BoxFit.scaleDown,
              )),

          //DATETIME & BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HelperFunctions.datetimeFormat(DateTime.now()),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon:
                          const ImageIcon(AssetImage("assets/news/icons.png"))),
                  IconButton(
                      onPressed: () {},
                      icon: liked
                          ? const ImageIcon(
                              AssetImage("assets/news/like- 2.png"))
                          : const ImageIcon(
                              AssetImage("assets/news/like- 2.png"))),
                ],
              )
            ],
          ),

          //TEXT CONTENT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lorem ipsum dolor sit amet consectetur. Vitae faucibus at scelerisque nibh quis. Nunc venenatis nam pellentesque magna nunc dolor etiam. Neque mauris diam ridiculus laoreet volutpat et cursus. Est gravida semper sagittis posuere tellus amet sed feugiat. Enim lectus scelerisque nunc viverra auctor et sapien. Tellus eget sed lacinia imperdiet suspendisse dolor sagittis neque. Amet vel justo neque massa enim viverra malesuada feugiat. Leo elementum lacus eget nec eget sed nisl. Turpis pretium nullam hac dolor amet accumsan dictum nulla gravida. Malesuada integer tincidunt malesuada metus. Neque nisi enim adipiscing ac est. Adipiscing tellus id risus mattis pretium amet varius cursus. Lacus id et ridiculus adipiscing sagittis. Lacus turpis mi sit imperdiet in accumsan bibendum faucibus auctor.",
                overflow: TextOverflow.ellipsis,
                maxLines: maxLinesMore ? 20 : 3,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      maxLinesMore = !maxLinesMore;
                    });
                  },
                  child: maxLinesMore
                      ? const Text("Скрыть")
                      : const Text("Читать дальше..."))
            ],
          ),

          TextButton(
              onPressed: () {
                nextScreen(
                    context,
                    Comments(comments: [
                      CommentTemplate("name", "userName", "", "textOfComment",
                          1, 2, "08:10")
                    ]));
              },
              child: Text(
                "Показать комментарии",
                style: HelperFunctions.pGrey,
              )),

          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      liked != liked;
                    });
                  },
                  icon: const ImageIcon(AssetImage("assets/icons.png"))),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.645,
                child: HelperFunctions.inputTemplate(
                    "", "Ваш комментарий...", context),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(AssetImage("assets/msg_icons.png"))),
            ],
          )
        ],
      ),
    );
  }
}
