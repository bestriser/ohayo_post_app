import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/user.dart';

class UserNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User _user;
  User get user => _user;
  String _password;
  String get password => _password;

  Stream<User> userStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot data) => User.fromDocumentSnapshot(data));
  }

  Future<void> getUser(String uid) async {
    try {
      if (uid.isEmpty) {
        _user = User.empty();
        notifyListeners();
        return;
      }
      final doc = await _db.collection('users').doc(uid).get();
      _user = User.fromDocumentSnapshot(doc);
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void setNickName(String nickName) {
    _user = _user.copyWith(nickName: nickName);
    notifyListeners();
  }

  void setEmail(String email) {
    _user = _user.copyWith(email: email);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
