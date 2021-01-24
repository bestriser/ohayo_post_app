import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)));
  }
}
