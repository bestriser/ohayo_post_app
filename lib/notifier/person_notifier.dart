import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/person.dart';

class PersonNotifier with ChangeNotifier {
  Person _person;
  Person get person => _person;
  String _password;
  String get password => _password; //ログイン時後は空文字で上書きする

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
