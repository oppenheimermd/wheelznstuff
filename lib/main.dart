import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/core/services/navigation_service.dart';
import 'package:wheelznstuff/locator.dart';
import 'package:wheelznstuff/managers/dialog_manager.dart';
import 'package:wheelznstuff/ui/router.dart';
import 'package:wheelznstuff/ui/views/startup_view.dart';

import 'core/model/appUser.dart';
import 'core/services/authenticationManager.dart';
import 'core/services/dialog_service.dart';
import 'core/services/navigation_manager.dart';

void main() async{
  //  call setupLocator before we run the app
  setupLocator();
  //  see: https://flutteragency.com/how-to-solve-no-firebase-app-has-been-created/
  //  Initialize [Firebase.initializeApp();] after calling WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>(
      initialData: AppUser.initial(),
      //  The user can now be consumed anywhere in the app by using Provider.of<User>(context)
      create: (context) => locator<AuthenticationManager>().userStreamController.stream,
      child: MaterialApp(
        builder: (context, child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(child: child))
        ),
        navigatorKey: locator<NavigationManager>().navigationKey,
        debugShowCheckedModeBanner: false,
        title: 'WheelznStuff',
        home: StartUpView(),
        onGenerateRoute: generateRoute,
        ),
      );
  }

}

