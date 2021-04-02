import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/data_service/person_data_service.dart';
import 'package:ohayo_post_app/data_service/post_data_service.dart';
import 'package:ohayo_post_app/model/post.dart';
import 'package:ohayo_post_app/model/wake_up_time.dart';
import 'package:ohayo_post_app/utility/convert.dart';

class PostNotifier with ChangeNotifier {
  PostNotifier.fromPosts(List<Post> posts) {
    if (posts != null) {
      _posts = posts;
    } else {
      _posts = <Post>[];
    }
  }

  Post _post = Post.empty();
  Post get post => _post; // おはよう報告の下書き機能が実装する時に使用予定

  List<Post> _posts;
  List<Post> get posts => _posts;

  List<WakeUpTime> get wakeUpTimes => _posts
      .map((post) => WakeUpTime(
            Convert().getMonthDayWeekDay(post.createdAt),
            Convert().getHourMinute(post.createdAt),
            post.createdAt,
          ))
      .toList();

  double get averageWakeUpTimes =>
      (wakeUpTimes.map((wakeUpTime) => wakeUpTime.time).reduce((value, element) => (value + element) / 2) * 10).round() / 10;

  void setTarget(String target) {
    _post = _post.copyWith(feeling: target);
    notifyListeners();
  }

  final _postDB = PostDataService();
  final _personDB = PersonDataService();

  Future<void> submitPost(String contributorId) async {
    _post = _post.copyWith(contributorId: contributorId);
    await _postDB.createPost(_post);
    notifyListeners();
  }

  /// TODO:現状、タイムライン画面を開く度に、全ポストと全ユーザーの紐付け処理が入り、データ量が増えた時に処理落ちする可能性があるので、ポストの表示に20件制限を追加したい
  Future<void> setContributorData(List<Post> posts) async {
    // StreamのinitialDataなどでpostsが空の場合は処理をスキップ
    if (posts.isEmpty) return;

    // 全ユーザーデータを取得
    final _persons = await _personDB.getAllPerson();

    // contributorDataの紐付が未完了のPostIDリストを作成
    final _unspecifiedPostIds = _posts.where((_post) => _post.contributorData == null).map((_post) => _post.postId).toList();

    // contributorDataの紐付が全て完了している場合は処理をスキップ
    if (_unspecifiedPostIds.isEmpty) return null;

    // contributorDataの紐付処理
    _posts = _posts.map((_post) {
      // contributorDataの紐付が完了しているPostIdは処理をスキップ
      if (!_unspecifiedPostIds.contains(_post.postId)) return _post;
      final _contributorData = _persons.firstWhere((_person) => _person.uid == _post.contributorId);
      return _post.copyWith(contributorData: _contributorData);
    }).toList();

    notifyListeners();
  }
}
