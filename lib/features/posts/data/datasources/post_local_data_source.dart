import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> posts) async {
    List postsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString("CACHED_POSTS", json.encode(postsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonPosts = sharedPreferences.getString("CACHED_POSTS");
    if (jsonPosts != null) {
      List decodedPostModels = json.decode(jsonPosts);
      List<PostModel> postModels = decodedPostModels
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();
      return Future.value(postModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
