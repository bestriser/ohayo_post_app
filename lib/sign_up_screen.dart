import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('朝活パーソン登録'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  String nickName;
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> loginUser(String nickName, String email, String password) {
    return users
        .add({
          'nickName': nickName,
          'email': email,
          'password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
                "ユーザー登録する",
              ),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('朝活パーソンの登録が完了しました。')));
                  return loginUser(nickName, email, password);
                } else {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('朝活パーソンの登録が失敗しました。')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
