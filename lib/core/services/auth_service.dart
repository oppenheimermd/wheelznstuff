
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:wheelznstuff/core/model/user.dart';

import '../../locator.dart';

abstract class AuthenticationService {

  Future<AppUser> currentUser();
  Future<AppUser> signInAnonymously();
  Future signInWithEmailAndPassword({String email, String password});
  Future createUserWithEmailAndPassword({ String email, String password, String firstname});
  Future<void> sendPasswordResetEmail(String email);
  Future<AppUser> signInWithEmailAndLink({String email, String link});
  bool isSignInWithEmailLink(String link);
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithFacebook();
  Future<void> signOut(BuildContext context);
  //Stream<AppUser> get onAuthStateChanged;
  Future<bool> isUserLoggedIn();
  Future _populateCurrentUser(User user);
  void dispose();
}

//  See:  https://github.com/bizz84/firebase_auth_demo_flutter/blob/master/lib/services/auth_service.dart