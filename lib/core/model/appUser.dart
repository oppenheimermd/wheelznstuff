import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//  See:  https://stackoverflow.com/questions/63597313/the-argument-type-mapstring-dynamic-function-cant-be-assigned-to-the-par


class AppUser {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  const AppUser({
    @required this.uid,
    @required this.email,
    @required this.photoUrl,
    @required this.displayName
  });

  static AppUser initial(){
    var initialUser = AppUser(
        uid: null,
        email: null,
        photoUrl: null,
        displayName: null
    );

    return initialUser;
  }

/*  AppUser.fromMap(Map snapshot) :
        uid = snapshot['uid'] ?? '',
        email = snapshot['email'] ?? '',
        photoUrl = snapshot['photoUrl'] ?? '',
        displayName = snapshot['displayName'] ?? '';

 */

  AppUser.fromMap(Map<String, dynamic> map(), )
      : assert(map()['uid'] != null),
        assert(map()['email'] != null),
        assert(map()['photoUrl'] != null),
        assert(map()['displayName'] != null),
        uid = map()['uid'],
        email = map()['email'],
        photoUrl = map()['photoUrl'],
        displayName = map()['displayName'];

  AppUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "AppUSer{uid: $uid, email: $email, photoUrl: $photoUrl, displayName: $displayName }";

  toJson() {
    return {
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "displayName":displayName
    };
  }

}
