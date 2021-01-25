import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseFirestore _storeDB = FirebaseFirestore.instance;
  final FirebaseAuth _authDB = FirebaseAuth.instance;
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
  String _registrationErrorMessage = '';
  String get registrationErrorMessage => _registrationErrorMessage;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isInitialized', value: isInitialized));
    properties.add(
        StringProperty('_initializedErrorMessage', _initializedErrorMessage));
    properties.add(FlagProperty('isLoggedIn', value: isLoggedIn));
    properties.add(StringProperty('loginErrorMessage', loginErrorMessage));
    properties.add(StringProperty('logoutError', logoutErrorMessage));
    properties.add(
        StringProperty('registrationErrorMessage', registrationErrorMessage));
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

  void setRegistrationErrorMessage(String registrationErrorMessage) {
    _registrationErrorMessage = registrationErrorMessage;
    notifyListeners();
  }

  Future<void> register(String nickName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _storeDB
          .collection('persons')
          .doc(userCredential.user.uid)
          .set({
            'uid': userCredential.user.uid,
            'nickName': nickName,
            'email': email,
            'createAt': Timestamp.now(),
          })
          .then((value) => print('Registered user'))
          .catchError((error) => print('Failed to register user: $error'));
      setRegistrationErrorMessage('');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setRegistrationErrorMessage('メールアドレスの形式が正しくありません。');
      } else if (e.code == 'email-already-in-use') {
        setRegistrationErrorMessage('そのメールアドレスのアカウントはすでに存在しています。');
      } else {
        setRegistrationErrorMessage(e.code);
      }
    } catch (e) {
      setRegistrationErrorMessage(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _authDB.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setLoginErrorMessage('');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setLoginErrorMessage('そのメールアドレスのユーザーは見つかりませんでした。');
      } else if (e.code == 'wrong-password') {
        setLoginErrorMessage('パスワードが間違っています。');
      }
    } catch (e) {
      setLoginErrorMessage(e);
    }
  }

  Future<void> logout() async {
    try {
      await _authDB.signOut();
      setLogoutErrorMessage('');
    } on FirebaseAuthException catch (e) {
      setLogoutErrorMessage(e.code);
    } catch (e) {
      setLogoutErrorMessage(e);
    }
  }
}
