import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/material.dart';

postWithImage(String imageUrl, int likes, List listOfComments, DateTime data,
    TimeOfDay time, String userImage, String nickName, String fio) {
  return Column(
    children: [
      topOfPost(nickName, userImage, fio),
      Image.network(imageUrl),
    ],
  );
}

topOfPost(String nickName, String imageUrl, String fio) {
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(imageUrl),
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        children: [
          Text(
            fio,
            style: HelperFunctions.h1,
          ),
          Text(
            nickName,
            style: HelperFunctions.pGrey,
          )
        ],
      )
    ],
  );
}

bottomOfPost(TimeOfDay time, DateTime dateTime, int likes) {
  String stringTime = '';
  String dateTime = '';
  if (time.hour < 10) {
    if (time.minute < 10) {
      stringTime = '0${time.hour}:0${time.minute}';
    } else {
      stringTime = '0${time.hour}:${time.minute}';
    }
  } else {
    if (time.minute < 10) {
      stringTime = '${time.hour}:0${time.minute}';
    } else {
      stringTime = '${time.hour}:${time.minute}';
    }
  }

  if (time.hour < 10) {
    if (time.minute < 10) {
      stringTime = '0${time.hour}:0${time.minute}';
    } else {
      stringTime = '0${time.hour}:${time.minute}';
    }
  } else {
    if (time.minute < 10) {
      stringTime = '${time.hour}:0${time.minute}';
    } else {
      stringTime = '${time.hour}:${time.minute}';
    }
  }
  return Row(
    children: [
      Row(
        children: [Text(stringTime)],
      )
    ],
  );
}
