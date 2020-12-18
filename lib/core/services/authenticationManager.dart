
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/core/model/appUser.dart';
import 'package:wheelznstuff/core/services/FirestoreService.dart';
import 'package:wheelznstuff/core/services/auth_service.dart';
import 'package:flutter/services.dart';

import '../../locator.dart';



class AuthenticationManager implements AuthenticationService{

  FirebaseAuth _firebaseAuth;
  FirestoreService _firestoreService;
  StreamController<AppUser> userStreamController;

  AuthenticationManager(){
    _firebaseAuth = FirebaseAuth.instance;
    _firestoreService = locator<FirestoreService>();
    userStreamController = StreamController<AppUser>();
  }

  User _currentUser;
  //  to avoid naming conflict currentUser => retrieveCurrentUser
  User get retrieveCurrentUser => _currentUser;

  AppUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Stream<AppUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AppUser> signInAnonymously() async {
    final UserCredential userCredential = await _firebaseAuth.signInAnonymously();

    var hasUser = userCredential != null;
    AppUser _appUser;

    if(hasUser){
      _appUser = _userFromFirebase(userCredential.user);
      userStreamController.add(_appUser);
    }

    return _appUser;
  }

  Future signInWithEmailAndPassword({String email, String password}) async {
    /*final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));

    var hasUser = userCredential != null;
    AppUser _appUser;

    if(hasUser){
      _appUser = _userFromFirebase(userCredential.user);
      userStreamController.add(_appUser);
    }

    return _appUser*/
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = _firebaseAuth.currentUser;
      var _appUser = _userFromFirebase(user);
      userStreamController.add(_appUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    var hasUser = userCredential != null;
    AppUser _appUser;

    if(hasUser){
      _appUser = _userFromFirebase(userCredential.user);
      userStreamController.add(_appUser);
    }

    return _appUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<AppUser> signInWithEmailAndLink({String email, String link}) async {
    final UserCredential userCredential =
    await _firebaseAuth.signInWithEmailLink(email: email, emailLink: link);
    var hasUser = userCredential != null;
    AppUser _appUser;

    if(hasUser){
      _appUser = _userFromFirebase(userCredential.user);
      userStreamController.add(_appUser);
    }

    return _appUser;
  }

  @override
  bool isSignInWithEmailLink(String link) {
    return _firebaseAuth.isSignInWithEmailLink(link);
  }

  //  See: https://fireship.io/lessons/flutter-firebase-google-oauth-firestore/
  @override
  Future<AppUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        //return _userFromFirebase(userCredential.user);


        //  Note we are only signed in with google but still
        //  need to create this user in the database

        var hasUser = userCredential != null;
        AppUser _appUser;

        if(hasUser){
          _appUser = _userFromFirebase(userCredential.user);
          userStreamController.add(_appUser);
        }

        return _appUser;
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<AppUser> signInWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    // https://github.com/roughike/flutter_facebook_login/issues/210
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final FacebookLoginResult result =
    await facebookLogin.logIn(<String>['public_profile']);
    if (result.accessToken != null) {
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(
            result.accessToken.token),
      );
      //return _userFromFirebase(userCredential.user);
      var hasUser = userCredential != null;
      AppUser _appUser;

      if(hasUser){
        _appUser = _userFromFirebase(userCredential.user);
        userStreamController.add(_appUser);
      }

      return _appUser;
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  AppUser currentUser() {
    final User user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    //final FacebookLogin facebookLogin = FacebookLogin();
    //await facebookLogin.logOut();

    //  see: C:\Users\moppenheimer\repo\flutter_tuts\filledStacks_tuts\provider_architecture2\lib\core\services
    //  Get user, using Provider
    var appuser = Provider.of<AppUser>(context);
    //  clear user data instance
    appuser = AppUser.initial();
    userStreamController.add(appuser);
    return _firebaseAuth.signOut();
  }

  //  https://github.com/FilledStacks/flutter-tutorials/blob/master/039-firebase-custom-start-user-profile/lib/services/authentication_service.dart
  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  //  https://github.com/FilledStacks/flutter-tutorials/blob/master/039-firebase-custom-start-user-profile/lib/services/authentication_service.dart
  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  @override
  void dispose() {
    //  Close instances of Sink to prevents memory leaks and unexpected behavior.
    //  See: https://dart-lang.github.io/linter/lints/close_sinks.html
    userStreamController.close();
  }


}

//  see: https://github.com/bizz84/firebase_auth_demo_flutter/blob/master/lib/services/firebase_auth_service.dart