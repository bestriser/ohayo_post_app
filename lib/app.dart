import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/counter.dart';
import 'package:ohayo_post_app/login_screen.dart';
import 'package:ohayo_post_app/registration_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おはようポスト',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'おはようポスト'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isInitialized = false;
  bool _initializedError = false;
  bool _isLoggedIn = false;

  void _initializeFlutterFire() {
    try {
      Firebase.initializeApp().whenComplete(() {
        setState(() => _isInitialized = true);
        FirebaseAuth.instance.authStateChanges().listen((User user) {
          if (user != null) {
            setState(() => _isLoggedIn = true);
          }
        });
      });
    } catch (e) {
      setState(() => _initializedError = true);
    }
  }

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
  void initState() {
    _initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                                          onPressed: () async {
                                            setState(() => _isLoggedIn = false);
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
                Column(
                  children: [
                    Text('_initialized: ${_isInitialized.toString()}'),
                    Text('_initializedError: ${_initializedError.toString()}'),
                    Text('_isLoggedIn: ${_isLoggedIn.toString()}'),
                  ],
                ),
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
        ),
        if (!_isInitialized)
          Center(child: CupertinoActivityIndicator(radius: 50)),
        if (_initializedError)
          AlertDialog(title: Text('initializeFlutterFire()でエラーが出ました')),
      ],
    );
  }
}
