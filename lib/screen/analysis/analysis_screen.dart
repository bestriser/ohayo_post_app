import 'package:flutter/material.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('分析')),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
