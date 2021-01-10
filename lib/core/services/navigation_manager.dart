
import 'package:flutter/material.dart';
import 'package:wheelznstuff/core/services/navigation_service.dart';

class NavigationManager implements NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  //   don't want the user to be able to press the device's back button to get
  //   back to the earlier route. Instead of calling pushNamed, try calling
  //   Navigator.pushReplacementNamed to cause the earlier route to disappear.
  Future<dynamic> navigateExit(String routeName, {dynamic arguments}){
    return _navigationKey.currentState
        .pushReplacementNamed(routeName,arguments: arguments);
  }
}