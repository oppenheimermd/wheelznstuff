import 'package:flutter/cupertino.dart';
import 'package:wheelznstuff/constants/route_names.dart';
import 'package:wheelznstuff/core/enums/form_types.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/model/appUser.dart';
import 'package:wheelznstuff/core/services/authenticationManager.dart';
import 'package:wheelznstuff/core/services/dialog_service.dart';
import 'package:wheelznstuff/core/services/navigation_manager.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';

import '../../locator.dart';

class LoginVM extends BaseViewModel {
  ////var user = Provider.of<User>(context)
  //GlobalKey<FormState> formKey;

  //GlobalKey<FormState> getFormKey() => formKey;

  AuthenticationManager _authenticationManager;
  DialogService _dialogService;
  NavigationManager _navigationService;


  LoginVM() {
    _authenticationManager = locator<AuthenticationManager>();
    _dialogService = locator<DialogService>();
    _navigationService = locator<NavigationManager>();
  }

  bool _validateAndSave({GlobalKey<FormState> formKey}) {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit({
    String email,
    String password,
    FormType formType,
    GlobalKey<FormState> formKey
  }) async {
    if (_validateAndSave(formKey: formKey)) {
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

  Future<void> interceptGoogleSignIn(LoginVM model) async {
    //authStatus = user  == null? AuthStatus.notSignedIn : AuthStatus.signedIn;
    var signedIn = await _authenticationManager.signInWithGoogle();
    /*if(signedIn.)
        {
          widget.onSignedIn();
        }*/
  }

}
