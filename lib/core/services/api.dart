import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wheelznstuff/core/model/vendor.dart';
import 'package:wheelznstuff/core/model/vendorList.dart';
import 'package:wheelznstuff/core/services/api_service.dart';
import 'package:flutter/services.dart' show rootBundle;

/// The service responsible for networking requests
class Api implements ApiService {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = new http.Client();

  Future<String> getJson({String jsonFilename}) async {
    return rootBundle.loadString(jsonFilename);
  }

  Future<List<Vendor>> getAllVendors() async {

    //  https://stackoverflow.com/questions/55430061/unhandled-exception-internallinkedhashmapstring-dynamic-is-not-a-subtype-of
    //var jsonData = json.decode(await getJson(jsonFilename: 'assets/json/vendors.json')) as Map<String, dynamic>;
    String vendors = await getJson(jsonFilename: 'assets/json/vendors.json');
    final jsonResponse = json.decode(vendors);
    var vendorList = VendorList.fromJson(jsonResponse);
    print("vendors " + vendorList.vendors[0].companyName);
    log('data: $vendorList');
    return vendorList.vendors;

  }

  /*Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');

    // Convert and return
    return User.fromJson(json.decode(response.body));
  }*/

  /*Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$endpoint/posts?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }*/

  /*Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = List<Comment>();

    // Get comments for post
    var response = await client.get('$endpoint/comments?postId=$postId');

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }

    return comments;
  }*/
}