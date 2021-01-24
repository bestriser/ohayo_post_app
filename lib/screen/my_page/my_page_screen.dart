import 'package:flutter/material.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
