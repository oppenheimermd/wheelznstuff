import 'package:flutter/material.dart';
import 'package:wheelznstuff/constants/route_names.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/services/authenticationManager.dart';
import 'package:wheelznstuff/core/services/navigation_manager.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';


import '../../locator.dart';

class HomeVM extends BaseViewModel {
  TabController tabController;

  AuthenticationManager _authenticationManager;
  NavigationManager _navigationService;


  HomeVM() {
    _authenticationManager = locator<AuthenticationManager>();
    _navigationService = locator<NavigationManager>();
  }


  TabController initTabView({@required TabController tabController, @required int length,
    @required TickerProvider tickerProvider}){
    setState(ViewState.Busy);
    tabController = new TabController(length: length, vsync: tickerProvider);
    this.tabController = tabController;
    setState(ViewState.Idle);
    return tabController;
  }

  Future<void> signOut(BuildContext buildContext) async {

    setState(ViewState.Busy);
    await _authenticationManager.signOut(buildContext);
    setState(ViewState.Idle);
    _navigationService.navigateExit(LoginViewRoute);
  }





  //  leads to error: Once tou have called dispose(), it can no longer
//  be used
  /*@override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }*/
}