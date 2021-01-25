import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  Person({
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
  Person copyWith({
    String uid,
    String nickName,
    String email,
    DateTime createAt,
    DateTime updateAt,
  }) {
    return Person(
      uid: uid ?? this.uid,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Firebaseにログインしていない時に使用する空のPersonを生成するメソッド
  factory Person.empty() {
    return Person(
      uid: '',
      nickName: '',
      email: '',
      createAt: null,
      updateAt: null,
    );
  }

  /// FirestoreのDataをPersonモデルに変換するメソッド
  factory Person.fromDocumentSnapshot(DocumentSnapshot doc) {
    return doc.exists
        ? Person(
            uid: doc.data()['uid'] ?? '',
            nickName: doc.data()['nickName'] ?? '',
            email: doc.data()['email'] ?? '',
            createAt: doc.data()['createAt'] != null
                ? (doc.data()['createAt'] as Timestamp).toDate()
                : null,
            updateAt: doc.data()['updateAt'] != null
                ? (doc.data()['updateAt'] as Timestamp).toDate()
                : null,
          )
        : Person.empty();
  }
}
