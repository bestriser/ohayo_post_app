import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/data_service/person_data_service.dart';
import 'package:ohayo_post_app/data_service/post_data_service.dart';
import 'package:ohayo_post_app/model/post.dart';

class PostNotifier with ChangeNotifier {
  PostNotifier.fromPosts(List<Post> posts) {
    _posts = posts;
  }
  List<Post> _posts;
  List<Post> get posts => _posts;
  Post _post = Post.empty();
  Post get post => _post; // おはよう報告の下書き機能が実装する時に使用予定

  void setTarget(String target) {
    _post = _post.copyWith(target: target);
    notifyListeners();
  }

  final _postDB = PostDataService();
  final _personDB = PersonDataService();

  Future<void> submitPost() async {
    _post = _post.copyWith(contributorId: posts[0].contributorId);
    await _postDB.createPost(_post);
    notifyListeners();
  }

  /// TODO:notifyListeners()を設置するとFutureBuilderが無限ループになるのでList<Post>をreturnしているけど、_postsが古くなってしまう可能性があるため、notifyListeners()をちゃんと発火させたい
  /// TODO:現状、タイムライン画面を開く度に、全ポストと全ユーザーの紐付け処理が入っているので、データ量が増えた時に処理落ちする可能性があるので直したい
  Future<List<Post>> setContributorData(List<Post> posts) async {
    // StreamのinitialDataなどでpostsが空の場合は処理をスキップ
    if (posts.isEmpty) return null;

    // 全ユーザーデータを取得
    final _persons = await _personDB.getAllPerson();

    // contributorDataの紐付が未完了のPostIDリストを作成
    final _unspecifiedPostIds = _posts
        .where((_post) => _post.contributorData == null)
        .map((_post) => _post.postId)
        .toList();

    // contributorDataの紐付が全て完了している場合は処理をスキップ
    if (_unspecifiedPostIds.isEmpty) return null;

    // contributorDataの紐付処理
    _posts = _posts.map((_post) {
      // contributorDataの紐付が完了しているPostIdは処理をスキップ
      //if (_unspecifiedPostIds.contains(_post.postId)) return _post;

      final _contributorData =
          _persons.firstWhere((_person) => _person.uid == _post.contributorId);

      return _post.copyWith(contributorData: _contributorData);
    }).toList();

    return _posts;
  }
}
