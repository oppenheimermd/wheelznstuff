

import 'package:wheelznstuff/core/model/vendor.dart';

abstract class ApiService{
  Future<List<Vendor>> getAllVendors();
  Future<String> getJson({String jsonFilename});
  //Future<List<Post>> getPostsForUser(int userId);
  //Future<List<Comment>> getCommentsForPost(int postId);
}