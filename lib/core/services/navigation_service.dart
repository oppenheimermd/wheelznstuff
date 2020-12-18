import 'package:flutter/material.dart';

abstract class NavigationService {
  void pop();
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});
}