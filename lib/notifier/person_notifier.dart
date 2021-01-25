import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/person.dart';

class PersonNotifier with ChangeNotifier {
  final FirebaseFirestore _storeDB = FirebaseFirestore.instance;
  Person _person;
  Person get person => _person;
  String _password;
  String get password => _password; //ログイン時後は空文字で上書きする

  Stream<Person> personStream(String uid) {
    return _storeDB
        .collection('persons')
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot data) => Person.fromDocumentSnapshot(data));
  }

  Future<void> getPerson(String uid) async {
    try {
      if (uid.isEmpty) {
        _person = Person.empty();
        notifyListeners();
        return;
      }
      final doc = await _storeDB.collection('persons').doc(uid).get();
      _person = Person.fromDocumentSnapshot(doc);
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void setNickName(String nickName) {
    _person = _person.copyWith(nickName: nickName);
    notifyListeners();
  }

  void setEmail(String email) {
    _person = _person.copyWith(email: email);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
