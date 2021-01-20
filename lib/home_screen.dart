import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/counter.dart';
import 'package:ohayo_post_app/login_screen.dart';
import 'package:ohayo_post_app/registration_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.title});
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;

  Future<String> _logout() async {
    String logoutError = '';
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      logoutError = e.code;
    }
    return logoutError;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isLoggedIn
                ? Column(
                    children: [
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '${context.watch<Counter>().count}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      RaisedButton(
                        child: Text('ログアウト'),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () async {
                          String _logoutError = await _logout();
                          if (_logoutError == '') {
                            showDialog<int>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ログアウトしました！'),
                                  actionsPadding: EdgeInsets.all(16),
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text('OK'),
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog<int>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(_logoutError),
                                  actionsPadding: EdgeInsets.all(16),
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text('OK'),
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text('ログイン'),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      RaisedButton(
                        child: Text('登録'),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 16),
            Text('_isLoggedIn: ${_isLoggedIn.toString()}'),
          ],
        ),
      ),
      floatingActionButton: _isLoggedIn
          ? FloatingActionButton(
              onPressed: () => context.read<Counter>().increment(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}
