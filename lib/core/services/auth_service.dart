
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:wheelznstuff/core/model/appUser.dart';

import '../../locator.dart';

abstract class AuthenticationService {

  AppUser currentUser();
  Future<AppUser> signInAnonymously();
  Future<AppUser> signInWithEmailAndPassword(String email, String password);
  Future<AppUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<AppUser> signInWithEmailAndLink({String email, String link});
  bool isSignInWithEmailLink(String link);
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithFacebook();
  Future<void> signOut(BuildContext context);
  Stream<AppUser> get onAuthStateChanged;
  void dispose();
}

//  See:  https://github.com/bizz84/firebase_auth_demo_flutter/blob/master/lib/services/auth_service.dart