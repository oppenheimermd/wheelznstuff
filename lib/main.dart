import 'package:flutter/material.dart';
import 'package:wheelznstuff/locator.dart';
import 'package:wheelznstuff/ui/router.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';
import 'package:wheelznstuff/ui/views/homeview.dart';

import 'core/view_models/homeVM.dart';

void main() {
  //  call setupLocator before we run the app
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      title: 'WheelznStuff',
      initialRoute: 'home',
      onGenerateRoute: Router.generateRoute,
    );
  }
}

