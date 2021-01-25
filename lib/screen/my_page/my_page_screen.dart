import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/user_notifier.dart';
import 'package:ohayo_post_app/widget/logout_button.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNtf = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('マイページ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userNtf.user.uid),
            Text(userNtf.user.nickName),
            Text(userNtf.user.email),
            LogoutButton(),
          ],
        ),
      ),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
