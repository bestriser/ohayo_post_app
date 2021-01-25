import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/data_service/post_data_service.dart';
import 'package:ohayo_post_app/model/post.dart';

class PostNotifier with ChangeNotifier {
  PostNotifier.fromPosts(List<Post> posts) : _posts = posts;
  final _postDB = PostDataService();
  List<Post> _posts;
  List<Post> get posts => _posts;
  Post _post = Post.empty();

  void setTarget(String target) {
    _post = _post.copyWith(target: target);
    notifyListeners();
  }

  Future<void> submitPost() async {
    _post = _post.copyWith(contributorId: posts[0].contributorId);
    await _postDB.createPost(_post);
  }
}
