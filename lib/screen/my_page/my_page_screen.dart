import 'package:flutter/material.dart';
import 'package:ohayo_post_app/widget/logout_button.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('マイページ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoutButton(),
          ],
        ),
      ),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
