import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/locator.dart';
import 'package:wheelznstuff/ui/router.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';
import 'package:wheelznstuff/ui/views/homeview.dart';

import 'core/model/appUser.dart';
import 'core/services/authenticationManager.dart';
import 'core/view_models/homeVM.dart';

void main() {
  //  call setupLocator before we run the app
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>(
      initialData: AppUser.initial(),
      create: (context) => locator<AuthenticationManager>().userStreamController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WheelznStuff',
        theme: ThemeData(),
        initialRoute: 'home',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }

  // This widget is the root of your application.
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      title: 'WheelznStuff',
      initialRoute: 'home',
      onGenerateRoute: Router.generateRoute,
    );
  }*/
}

