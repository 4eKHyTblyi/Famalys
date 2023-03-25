import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseService {
  addUserData() {
    var myUid = FirebaseAuth.instance.currentUser!.uid;
    var doc = FirebaseFirestore.instance.collection('users').doc(myUid).set({
      'uid': myUid,
      'name': '',
      'avatar':
          'https://firebasestorage.googleapis.com/v0/b/famalys-ed5ed.appspot.com/o/profile.png?alt=media&token=2a5b6783-9ce1-4193-a4d6-f33751d8a4b7'
    });
    FirebaseAuth.instance.currentUser!.updatePhotoURL(
        'https://firebasestorage.googleapis.com/v0/b/famalys-ed5ed.appspot.com/o/profile.png?alt=media&token=2a5b6783-9ce1-4193-a4d6-f33751d8a4b7');
  }
}
