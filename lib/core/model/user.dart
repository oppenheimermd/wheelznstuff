import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//  See:  https://stackoverflow.com/questions/63597313/the-argument-type-mapstring-dynamic-function-cant-be-assigned-to-the-par


class AppUser {
  final String uid;
  final String email;
  final String photoUrl;
  final String firstName;

  const AppUser({
    @required this.uid,
    @required this.email,
    this.photoUrl,
    @required this.firstName,
  });

  static AppUser initial(){
    var initialUser = AppUser(
        uid: null,
        email: null,
        photoUrl: null,
        firstName: null,
    );

    return initialUser;
  }

  AppUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        photoUrl = data['photoUrl'],
        firstName = data['firstName'];

  @override
  String toString() => "AppUSer{firstName: $firstName, uid: $uid, firstName: $firstName, email: $email }";

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "firstName": firstName
    };
  }


/*  AppUser.fromMap(Map snapshot) :
        uid = snapshot['uid'] ?? '',
        email = snapshot['email'] ?? '',
        photoUrl = snapshot['photoUrl'] ?? '',
        displayName = snapshot['displayName'] ?? '';



  AppUser.fromMap(Map<String, dynamic> map(), )
      : assert(map()['uid'] != null),
        assert(map()['email'] != null),
        assert(map()['photoUrl'] != null),
        assert(map()['displayName'] != null),
        uid = map()['uid'],
        email = map()['email'],
        photoUrl = map()['photoUrl'],
        displayName = map()['displayName'];

*/

}
