import 'package:flutter/widgets.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';

/// Shared ViewModel functionality for [setState]
///
/// We have a state property that tells us what
/// UI layout to show in the view and when it's
/// updated we want to call notifyListeners
class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}