import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohayo_post_app/model/person.dart';

class Post {
  Post({
    this.contributorId,
    this.contributorData,
    this.postId,
    this.sleepingRecords,
    this.reflection,
    this.feeling,
    this.target,
    this.createdAt,
    this.updatedAt,
  });

  /// 投稿者ID
  final String contributorId;

  /// 投稿者の情報（personsコレクションから受け取る）
  final Person contributorData;

  /// ポストID
  final String postId;

  /// 睡眠記録
  final Map<String, dynamic> sleepingRecords;

  /// 昨日の振り返り
  final String reflection;

  /// 今朝の気持ち
  final String feeling;

  /// 今日の目標
  final String target;

  /// 登録日
  final DateTime createdAt;

  /// 更新日
  final DateTime updatedAt;

  /// 外部から値を代入するメソッド
  Post copyWith({
    String contributorId,
    Person contributorData,
    String postId,
    Map<String, int> sleepingRecords,
    String reflection,
    String feeling,
    String target,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Post(
      contributorId: contributorId ?? this.contributorId,
      contributorData: contributorData ?? this.contributorData,
      postId: postId ?? this.postId,
      sleepingRecords: sleepingRecords ?? this.sleepingRecords,
      reflection: reflection ?? this.reflection,
      feeling: feeling ?? this.feeling,
      target: target ?? this.target,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// StreamやNotifierの初期化処理用のPostモデルを生成するメソッド
  factory Post.empty() {
    return Post(
      contributorId: '',
      contributorData: null,
      postId: '',
      sleepingRecords: null,
      reflection: '',
      feeling: '',
      target: '',
      createdAt: null,
      updatedAt: null,
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
      feeling: data['feeling'] ?? '',
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
