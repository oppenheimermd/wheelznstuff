import 'package:flutter/cupertino.dart';
import 'package:wheelznstuff/constants/route_names.dart';
import 'package:wheelznstuff/core/enums/form_types.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/services/authenticationManager.dart';
import 'package:wheelznstuff/core/services/dialog_service.dart';
import 'package:wheelznstuff/core/services/navigation_manager.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';

import '../../locator.dart';

class LoginVM extends BaseViewModel{
  ////var user = Provider.of<User>(context)


  AuthenticationManager _authenticationManager;
  DialogService _dialogService;
  NavigationManager _navigationService;


  LoginVM() {
    _authenticationManager = locator<AuthenticationManager>();
    _dialogService = locator<DialogService>();
    _navigationService = locator<NavigationManager>();
  }

  bool validateAndSave({GlobalKey<FormState> formKey}) {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmitLogin({
    @required String email,
    @required String password,
    @required FormType formType,
    @required GlobalKey<FormState> formKey
  }) async {
    if (validateAndSave(formKey: formKey)) {
      setState(ViewState.Busy);

      var result = await _authenticationManager.signInWithEmailAndPassword(
          email: email, password: password);

      setState(ViewState.Idle);

      if (result is bool) {
        if (result) {
          _navigationService.navigateTo(HomeViewRoute);
        } else {
          await _dialogService.showDialog(
            title: 'Login Failure',
            description: 'General login failure. Please try again later',
          );
        }
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: result,
        );
      }
    }
  }

  Future<void> validateAndSubmitSignUp({
    @required String email,
    @required String password,
    @required String firstname,
    @required FormType formType,
    @required GlobalKey<FormState> formKey
  }) async {
    if (validateAndSave(formKey: formKey)) {
      setState(ViewState.Busy);

      var result = await _authenticationManager.createUserWithEmailAndPassword(
          email: email, password: password, firstname: firstname);

      setState(ViewState.Idle);

      if (result is bool) {
        if (result) {
          _navigationService.navigateTo(HomeViewRoute);
        } else {
          await _dialogService.showDialog(
            title: 'Sign-up Failure',
            description: 'General failure. Please try again later',
          );
        }
      } else {
        await _dialogService.showDialog(
          title: 'Sign-up Failure',
          description: result,
        );
      }
    }
  }

  Future<void> interceptGoogleSignIn(LoginVM model) async {
    //authStatus = user  == null? AuthStatus.notSignedIn : AuthStatus.signedIn;
    var signedIn = await _authenticationManager.signInWithGoogle();
    /*if(signedIn.)
        {
          widget.onSignedIn();
        }*/
  }



  void moveToRegister(GlobalKey<FormState> formKey) {
    setState(ViewState.Busy);
    formKey.currentState.reset();
    setState(ViewState.Idle);
  }

  void moveToLogin(GlobalKey<FormState> formKey) {
    setState(ViewState.Busy);
    formKey.currentState.reset();
    setState(ViewState.Idle);
  }

}
