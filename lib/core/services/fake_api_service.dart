
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wheelznstuff/core/model/vendor.dart';
import 'package:wheelznstuff/core/model/vendorList.dart';

class FakeApiService{
  Future<String> getJson({String jsonFilename}) async {
    return rootBundle.loadString(jsonFilename);
  }

  Future<List<Vendor>> getAllVendors() async {

    //  https://stackoverflow.com/questions/55430061/unhandled-exception-internallinkedhashmapstring-dynamic-is-not-a-subtype-of
    //var jsonData = json.decode(await getJson(jsonFilename: 'assets/json/vendors.json')) as Map<String, dynamic>;
    String vendors = await getJson(jsonFilename: 'assets/json/vendors.json');
    final jsonResponse = json.decode(vendors);
    var vendorList = VendorList.fromJson(jsonResponse);
    //print("vendors " + vendorList.vendors[0].companyName);
    //log('data: $vendorList');
    return vendorList.vendors;

  }
}