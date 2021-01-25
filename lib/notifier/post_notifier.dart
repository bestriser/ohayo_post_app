import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/post.dart';

class PostNotifier with ChangeNotifier {
  PostNotifier.fromPosts(List<Post> posts) : _posts = posts;
  List<Post> _posts;
  List<Post> get posts => _posts;
  Post _post;
  Post get post => _post;

  void setTarget(String target) {
    _post = _post.copyWith(target: target);
    notifyListeners();
  }
}
