
import 'package:wheelznstuff/core/model/vendor.dart';

class VendorList{
  final List<Vendor> vendors;

  VendorList({
    this.vendors
  });

  //  see: https://stackoverflow.com/questions/55430061/unhandled-exception-internallinkedhashmapstring-dynamic-is-not-a-subtype-of
  //  for the different type of json array
  factory VendorList.fromJson(Map<String, dynamic> json) {

    VendorList vendors;

    json.forEach((key, value) {
      //vendors = VendorList.fromJson(value);
      var _vendors = VendorList.fromJsonToList(value);
      vendors = _vendors;
    });

    /*List<Vendor> vendors = new List<Vendor>();
    vendors = json.map((i)=>Vendor.fromJson(i)).toList();*/

    return vendors;
  }

  factory VendorList.fromJsonToList(List<dynamic> json) {

    List<Vendor> vendors = new List<Vendor>();
    vendors = json.map((i)=>Vendor.fromJson(i)).toList();
    return new VendorList(
        vendors: vendors
    );
  }
}