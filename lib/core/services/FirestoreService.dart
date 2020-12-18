import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wheelznstuff/core/model/appUser.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  FirebaseFirestore.instance.collection('users');

  Future createUser(AppUser user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return AppUser.fromMap(userData.data);
    } catch (e) {
      return e.message;
    }
  }
}