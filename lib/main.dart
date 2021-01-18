import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/registration_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isInitialized = false;
  bool _initializedError = false;
  bool _isSigned = false;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _initializeFlutterFire() {
    try {
      Firebase.initializeApp().whenComplete(() {
        setState(() => _isInitialized = true);
        FirebaseAuth.instance.authStateChanges().listen((User user) {
          if (user != null) {
            setState(() => _isSigned = true);
          }
        });
      });
    } catch (e) {
      setState(() => _initializedError = true);
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() => _isSigned = false);
      }
    });
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
                _isSigned
                    ? Column(
                        children: [
                          Text(
                            'You have pushed the button this many times:',
                          ),
                          Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          RaisedButton(
                            child: Text(
                              "ログアウト",
                            ),
                            color: Colors.orange,
                            textColor: Colors.white,
                            onPressed: () => _logout(),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            child: Text(
                              "ログイン",
                            ),
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
                          const SizedBox(width: 16),
                          RaisedButton(
                            child: Text(
                              "登録",
                            ),
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
                    Text('_isSigned: ${_isSigned.toString()}'),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: _isSigned
              ? FloatingActionButton(
                  onPressed: _incrementCounter,
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
