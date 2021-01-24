import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/screen/login/login_screen.dart';
import 'package:ohayo_post_app/screen/registration/registration_screen.dart';
import 'package:ohayo_post_app/widget/logout_button.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !firebaseNtf.isLoggedIn
                ? Row(
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
                  )
                : LogoutButton(),
          ],
        ),
      ),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
