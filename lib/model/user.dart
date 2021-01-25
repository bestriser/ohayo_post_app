import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    this.uid,
    this.nickName,
    this.email,
    this.createAt,
    this.updateAt,
  });

  /// uid
  final String uid;

  /// ニックネーム
  final String nickName;

  /// メールアドレス
  final String email;

  /// 登録日
  final DateTime createAt;

  /// 更新日
  final DateTime updateAt;

  /// 外部から値を代入するメソッド
  User copyWith({
    String uid,
    String nickName,
    String email,
    DateTime createAt,
    DateTime updateAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Firebaseにログインしていない時に使用する空のUserを生成するメソッド
  factory User.empty() {
    return User(
      uid: '',
      nickName: '',
      email: '',
      createAt: null,
      updateAt: null,
    );
  }

  /// FirestoreのDataをUserモデルに変換するメソッド
  factory User.fromDocumentSnapshot(DocumentSnapshot doc) {
    return doc.exists
        ? User(
            uid: doc['uid'] ?? '',
            nickName: doc['nickName'] ?? '',
            email: doc['email'] ?? '',
            createAt: doc['createAt'] ?? null,
            updateAt: doc['updateAt'] ?? null,
          )
        : User.empty();
  }
}
