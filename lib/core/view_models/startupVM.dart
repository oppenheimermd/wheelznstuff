
import 'package:wheelznstuff/constants/route_names.dart';
import 'package:wheelznstuff/core/services/authenticationManager.dart';
import 'package:wheelznstuff/core/services/navigation_manager.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';
import 'package:wheelznstuff/locator.dart';

class StartUpVM extends BaseViewModel{
  final AuthenticationManager _authenticationManager = locator<AuthenticationManager>();
  NavigationManager _navigationManager;


  StartUpVM(){
    _navigationManager = locator<NavigationManager>();
  }

  Future handleStartUp() async{
    var hasLoggedInUser = await _authenticationManager.isUserLoggedIn();

    if(hasLoggedInUser){
      _navigationManager.navigateTo(HomeViewRoute);

    }else {
      _navigationManager.navigateTo(LoginViewRoute);
    }
  }

}