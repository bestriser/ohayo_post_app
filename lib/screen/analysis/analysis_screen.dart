import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/screen/analysis/wake_up_times_screen.dart';
import 'package:ohayo_post_app/widget/posting_floating_action_button.dart';
import 'package:provider/provider.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('分析')),
      floatingActionButton: PostingFloatingActionButton(),
      body: Card(
        child: TextButton(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '起床時間',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('平均：${postNtf.averageWakeUpTimes}時起'),
              ],
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WakeUpTimesScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
