import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Histories extends StatefulWidget {
  CollectionReference<HistoryTemplate> histories;
  Histories({super.key, required this.histories});

  @override
  State<Histories> createState() => _HistoriesState();
}

class _HistoriesState extends State<Histories> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<HistoryTemplate>>(
        stream: widget.histories.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.size,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Row(
                    children: [addNewHostory(), lentaNovostey()],
                  );
                } else {
                  return lentaNovostey();
                }
              });
        });
  }

  addNewHostory() {
    return Container(
      decoration: HelperFunctions().kGradientBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: HelperFunctions().kInnerDecoration,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
            height: 55,
            width: 55,
            child: const Center(child: Icon(Icons.add)),
          ),
        ),
      ),
    );
  }

  lentaNovostey() {
    return Container(
      margin: const EdgeInsets.only(left: 7),
      decoration: HelperFunctions().kGradientBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: HelperFunctions().kInnerDecoration,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
            height: 55,
            width: 55,
          ),
        ),
      ),
    );
  }
}

@immutable
class HistoryTemplate {
  HistoryTemplate({
    required this.name,
    required this.userName,
    required this.photoUrl,
    required this.content,
  });

  HistoryTemplate.fromJson(Map<String, Object?> json)
      : this(
          content: json['content']! as String,
          name: json['name']! as String,
          userName: json['userNmae']! as String,
          photoUrl: json['photoUrl']! as String,
        );

  String name = "";
  String userName = "";
  String photoUrl = "";
  String content = "";

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'userName': userName,
      'photoUrl': photoUrl,
      'content': content,
    };
  }
}
