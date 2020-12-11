import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/model/vendor.dart';
import 'package:wheelznstuff/core/services/api_service.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';

import '../../locator.dart';

class HomeVM extends BaseViewModel {
  ApiService _api = locator<ApiService>();

  List<Vendor> vendors;

  ///  When the home view is initialized we want to call the
  ///  [getVendors] function to get the posts for this user.
  Future getVendors() async {
    setState(ViewState.Busy);
    vendors = await _api.getAllVendors();
    setState(ViewState.Idle);
  }
}