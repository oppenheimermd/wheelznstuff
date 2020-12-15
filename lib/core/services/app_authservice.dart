
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wheelznstuff/core/model/appUser.dart';

abstract class AppAuthService{

  bool isLoggedIn();

  Future<AppUser> signInAnonymously() ;

  Future signInWithEmailAndPassword({
    @required String email,
    @required String password
  });

  Future<AppUser> signInWithGoogle();

  Future<bool> createUserData(AppUser user);

  Future<AppUser> createUserWithEmailAndPassword( String email, String password, String username);

  Future<void> sendPasswordResetEmail(String email);

  Future<AppUser> signInWithEmailAndLink({String email, String link});

  bool isSignInWithEmailLink(String link);

  AppUser currentUser();

  StreamController<AppUser> getStreamController();

  Future<void> signOut(BuildContext context);

}