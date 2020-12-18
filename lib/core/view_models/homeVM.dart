import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/model/vendor.dart';
import 'package:wheelznstuff/core/services/fake_api_service.dart';
import 'package:wheelznstuff/core/view_models/baseViewModel.dart';

import '../../locator.dart';

class HomeVM extends BaseViewModel {
  FakeApiService _fakeApiService = locator<FakeApiService>();

  List<Vendor> vendors;

  ///  When the home view is initialized we want to call the
  ///  [getVendors] function to get the posts for this user.
  Future getVendors() async {
    setState(ViewState.Busy);
    vendors = await _fakeApiService.getAllVendors();
    setState(ViewState.Idle);
  }
}