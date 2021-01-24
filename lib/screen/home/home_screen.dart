import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/counter_notifier.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/screen/login/login_screen.dart';
import 'package:ohayo_post_app/screen/registration/registration_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);
    final counterNtf = Provider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            firebaseNtf.isLoggedIn
                ? Column(
                    children: [
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '${counterNtf.count}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      RaisedButton(
                        child: Text('ログアウト'),
                        color: Colors.orange,
                        onPressed: () async {
                          await firebaseNtf.logout();
                          if (firebaseNtf.logoutErrorMessage == '') {
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
                                      onPressed: () async {
                                        firebaseNtf.setIsLoggedIn(false);
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
                                  title: Text(firebaseNtf.logoutErrorMessage),
                                  actionsPadding: EdgeInsets.all(16),
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text('OK'),
                                      color: Colors.orange,
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
            Text('_isLoggedIn: ${firebaseNtf.isLoggedIn.toString()}'),
          ],
        ),
      ),
      floatingActionButton: firebaseNtf.isLoggedIn
          ? FloatingActionButton(
              onPressed: () => counterNtf.increment(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}
