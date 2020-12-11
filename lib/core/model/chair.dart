import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Chair{
  final String uid;
  final String chairName;
  final int brandId;
  final int vendorId;
  final double basePrice;
  final String imageUrl;

  const Chair({
    @required this.uid,
    @required this.chairName,
    @required this.brandId,
    @required this.vendorId,
    this.basePrice,
    @required this.imageUrl
  });

  static Chair initial(){
    var initialChair = Chair(
      uid: null,
      chairName: null,
      brandId: null,
      vendorId: null,
      basePrice: null,
      imageUrl: null
    );

    return initialChair;
  }

  Chair.fromMap(Map<String, dynamic> map(),)
      : assert(map()['uid'] != null),
        assert(map()['chairName'] != null),
        assert(map()['brandId'] != null),
        assert(map()['vendorId'] != null),
        assert(map()['basePrice'] != null),
        assert(map()['imageUrl'] != null),
        uid = map()['uid'],
        chairName = map()['chairName'],
        brandId = map()['brandId'],
        vendorId = map()['vendorId'],
        basePrice = map()['basePrice'],
        imageUrl = map()['imageUrl'];

}