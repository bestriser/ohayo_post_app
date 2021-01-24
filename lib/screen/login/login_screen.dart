import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/notifier/user_notifier.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
        centerTitle: true,
      ),
      body: LoginScreenForm(),
    );
  }
}

class LoginScreenForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenFormState();
  }
}

class LoginScreenFormState extends State<LoginScreenForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);
    final userNtf = Provider.of<UserNotifier>(context);

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
              onSaved: userNtf.setEmail,
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
              onSaved: userNtf.setPassword,
            ),
            const SizedBox(height: 16),
            RaisedButton(
              child: Text(
                'ログインする',
              ),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await firebaseNtf.login(userNtf.email, userNtf.password);
                  firebaseNtf.setIsLoggedIn(true);
                  if (firebaseNtf.loginErrorMessage == '') {
                    showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('おかえりなさい！\nまた一緒に朝活を楽しみましょう！'),
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
                      },
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(firebaseNtf.loginErrorMessage),
                      ),
                    );
                  }
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('入力内容を確認して下さい。'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
