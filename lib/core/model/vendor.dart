import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

//  See:  https://stackoverflow.com/questions/63597313/the-argument-type-mapstring-dynamic-function-cant-be-assigned-to-the-par


class Vendor {
  final String uid;
  final String companyName;
  final String logo;
  final String emailAddress;
  final String web;

  const Vendor({
    @required this.uid,
    @required this.companyName,
    this.logo,
    this.emailAddress,
    this.web
  });

  static Vendor initial() {
    var initialVendor = Vendor(
        uid: null,
        companyName: null,
        logo: null,
        emailAddress: null,
        web: null
    );

    return initialVendor;
  }

  Vendor.fromMap(Map<String, dynamic> map(),)
      : assert(map()['uid'] != null),
        assert(map()['companyName'] != null),
        assert(map()['logo'] != null),
        assert(map()['emailAddress'] != null),
        assert(map()['web'] != null),
        uid = map()['uid'],
        companyName = map()['companyName'],
        logo = map()['logo'],
        emailAddress = map()['emailAddress'],
        web = map()['web'];

  //  https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
  factory Vendor.fromJson(Map<String, dynamic> json){
    return new Vendor(
        uid: json['uid'].toString(),
        companyName: json['companyName'],
        logo: json['logo'],
        emailAddress: json['emailAddress'],
        web: json['web']
    );
  }

    @override
    String toString() => "AppUSer{uid: $uid, companyName: $companyName }";


    toJson() {
      return {
        "uid": uid,
        "companyName": companyName,
        "logo": logo,
        "emailAddress": emailAddress,
        "web": web
      };
    }

    /*Vendor.fromSnapshot(DocumentSnapshot snapshot)
        : this.fromMap(snapshot.data, reference: snapshot.reference);*/
}