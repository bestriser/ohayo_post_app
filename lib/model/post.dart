import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.contributorId,
    this.postId,
    this.sleepingRecords,
    this.reflection,
    this.target,
    this.createdAt,
    this.updatedAt,
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
  final DateTime createdAt;

  /// 更新日
  final DateTime updatedAt;

  /// 外部から値を代入するメソッド
  Post copyWith({
    String contributorId,
    String postId,
    Map<String, int> sleepingRecords,
    String reflection,
    String target,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Post(
      contributorId: contributorId ?? this.contributorId,
      postId: postId ?? this.postId,
      sleepingRecords: sleepingRecords ?? this.sleepingRecords,
      reflection: reflection ?? this.reflection,
      target: target ?? this.target,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
