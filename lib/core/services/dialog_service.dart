import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wheelznstuff/core/model/dialog_model.dart';

abstract class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  });

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog(
      {String title,
        String description,
        String confirmationTitle = 'Ok',
        String cancelTitle = 'Cancel'});

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response);
}