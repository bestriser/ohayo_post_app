import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  Person({
    this.uid,
    this.nickName,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  /// uid
  final String uid;

  /// ニックネーム
  final String nickName;

  /// メールアドレス
  final String email;

  /// 登録日
  final DateTime createdAt;

  /// 更新日
  final DateTime updatedAt;

  /// 外部から値を代入するメソッド
  Person copyWith({
    String uid,
    String nickName,
    String email,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Person(
      uid: uid ?? this.uid,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// StreamのinitialData用のPersonモデルを生成するメソッド
  factory Person.empty() {
    return Person(
      uid: '',
      nickName: '',
      email: '',
      createdAt: null,
      updatedAt: null,
    );
  }

  /// FirestoreのDataをPersonモデルに変換するメソッド
  factory Person.fromDocumentSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    return Person(
      uid: data['uid'] ?? '',
      nickName: data['nickName'] ?? '',
      email: data['email'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (snap.data()['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
