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

  /// StreamのinitialData用のPersonを生成するメソッド
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
  factory Person.fromDocumentSnapshot(DocumentSnapshot snap) {
    return Person(
      uid: snap.data()['uid'] ?? '',
      nickName: snap.data()['nickName'] ?? '',
      email: snap.data()['email'] ?? '',
      createAt: snap.data()['createAt'] != null
          ? (snap.data()['createAt'] as Timestamp).toDate()
          : null,
      updateAt: snap.data()['updateAt'] != null
          ? (snap.data()['updateAt'] as Timestamp).toDate()
          : null,
    );
  }
}
