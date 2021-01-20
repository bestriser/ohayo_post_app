import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  String _nickName;
  String get nickName => _nickName;
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;

  void setNickName(String nickName) {
    _nickName = nickName;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('nickName', nickName));
    properties.add(StringProperty('email', email));
    properties.add(StringProperty('password', password));
  }
}
