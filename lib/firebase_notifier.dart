import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  String _initializedErrorMessage = '';
  String get initializedErrorMessage => _initializedErrorMessage;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;
  String _logoutErrorMessage = '';
  String get logoutErrorMessage => _logoutErrorMessage;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isInitialized', value: isInitialized));
    properties.add(
        StringProperty('_initializedErrorMessage', _initializedErrorMessage));
    properties.add(FlagProperty('isLoggedIn', value: isLoggedIn));
    properties.add(StringProperty('loginErrorMessage', loginErrorMessage));
    properties.add(StringProperty('logoutError', logoutErrorMessage));
  }

  void setIsInitialized(bool isInitialized) {
    _isInitialized = isInitialized;
    notifyListeners();
  }

  void setInitializedErrorMessage(String initializedErrorMessage) {
    _initializedErrorMessage = initializedErrorMessage;
    notifyListeners();
  }

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  void setLoginErrorMessage(String loginErrorMessage) {
    _loginErrorMessage = loginErrorMessage;
    notifyListeners();
  }

  void setLogoutErrorMessage(String logoutErrorMessage) {
    _logoutErrorMessage = logoutErrorMessage;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _loginErrorMessage = 'そのメールアドレスのユーザーは見つかりませんでした。';
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        _loginErrorMessage = 'パスワードが間違っています。';
        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      _logoutErrorMessage = e.code;
      notifyListeners();
    }
  }
}
