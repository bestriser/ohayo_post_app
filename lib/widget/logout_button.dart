import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/screen/root/root_screen.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);

    return Column(
      children: [
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RootScreen(),
                            ),
                          );
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
    );
  }
}
