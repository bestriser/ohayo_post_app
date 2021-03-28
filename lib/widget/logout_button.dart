import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/widget/restart_widget.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);

    return Column(
      children: [
        ElevatedButton(
          child: Text('ログアウト'),
          style: ElevatedButton.styleFrom(primary: Colors.orange),
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
                      ElevatedButton(
                        child: Text('OK'),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () async {
                          firebaseNtf.setIsLoggedIn(false);
                          RestartWidget.restartApp(context);
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
                      ElevatedButton(
                        child: Text('OK'),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () => RestartWidget.restartApp(context),
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
