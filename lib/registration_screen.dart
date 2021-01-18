import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('朝活パーソン登録'),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  String nickName;
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> registerUser(
      String nickName, String email, String password) async {
    String authenticatedError = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await users
          .add({
            'uid': userCredential.user.uid,
            'nickName': nickName,
            'email': email,
            'createAt': Timestamp.now(),
          })
          .then((value) => print("Registered user"))
          .catchError((error) => print("Failed to register user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        authenticatedError = 'メールアドレスの形式が正しくありません。';
      } else if (e.code == 'email-already-in-use') {
        authenticatedError = 'そのメールアドレスのアカウントはすでに存在しています。';
      } else {
        authenticatedError = e.code;
      }
    } catch (e) {
      print(e);
    }
    return authenticatedError;
  }

  void _setNickName(String e) {
    setState(() => nickName = e);
  }

  void _setEmail(String e) {
    setState(() => email = e);
  }

  void _setPassword(String e) {
    setState(() => password = e);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 1,
              maxLengthEnforced: false,
              autofocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'ニックネームが入力されていません。';
                }
                if (value.length > 10) {
                  return 'ニックネームが10文字を超えています。';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.face_outlined),
                hintText: 'ニックネームを入力してください',
                labelText: 'ニックネーム（10文字以内） *',
              ),
              onSaved: _setNickName,
            ),
            TextFormField(
              maxLines: 1,
              maxLengthEnforced: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'メールアドレスが入力されていません。';
                }
                if (!value.contains('@')) {
                  return 'メールアドレスに「@」が含まれていません。';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.mail_outline),
                hintText: 'メールアドレスを入力してください',
                labelText: 'メールアドレス *',
              ),
              onSaved: _setEmail,
            ),
            TextFormField(
              maxLines: 1,
              maxLengthEnforced: false,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'パスワードが入力されていません。';
                }
                if (value.length < 8) {
                  return 'パスワードが8文字未満です。';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key_outlined),
                hintText: 'パスワードを入力してください',
                labelText: 'パスワード（8文字以上） *',
              ),
              onSaved: _setPassword,
            ),
            const SizedBox(height: 16),
            RaisedButton(
              child: Text(
                "登録する",
              ),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  var _authenticatedError =
                      await registerUser(nickName, email, password);
                  if (_authenticatedError == '') {
                    showDialog<int>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('朝活パーソンの登録が完了しました。'),
                            actionsPadding: EdgeInsets.all(16),
                            actions: <Widget>[
                              RaisedButton(
                                child: Text('OK'),
                                color: Colors.orange,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(_authenticatedError)));
                  }
                } else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('入力内容を確認して下さい。')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
