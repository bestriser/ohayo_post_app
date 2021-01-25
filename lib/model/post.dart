import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.contributorId,
    this.postId,
    this.sleepingRecords,
    this.reflection,
    this.target,
    this.createAt,
    this.updateAt,
  });

  /// 投稿者ID
  final String contributorId;

  /// ポストID
  final String postId;

  /// 睡眠記録
  final Map<String, dynamic> sleepingRecords;

  /// 昨日の振り返り
  final String reflection;

  /// 今日の目標
  final String target;

  /// 登録日
  final DateTime createAt;

  /// 更新日
  final DateTime updateAt;

  /// 外部から値を代入するメソッド
  Post copyWith({
    String contributorId,
    String postId,
    Map<String, int> sleepingRecords,
    String reflection,
    String target,
    DateTime createAt,
    DateTime updateAt,
  }) {
    return Post(
      contributorId: contributorId ?? this.contributorId,
      postId: postId ?? this.postId,
      sleepingRecords: sleepingRecords ?? this.sleepingRecords,
      reflection: reflection ?? this.reflection,
      target: target ?? this.target,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// FirestoreのDataをPostモデルに変換するメソッド
  factory Post.fromDocumentSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    return Post(
      contributorId: data['contributorId'] ?? '',
      postId: data['postId'] ?? '',
      sleepingRecords: data['sleepingRecords'] ?? null,
      reflection: data['reflection'] ?? '',
      target: data['target'] ?? '',
      createAt: data['createAt'] != null
          ? (data['createAt'] as Timestamp).toDate()
          : null,
      updateAt: data['updateAt'] != null
          ? (data['updateAt'] as Timestamp).toDate()
          : null,
    );
  }
}
