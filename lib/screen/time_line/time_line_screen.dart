import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/utility/convert.dart';
import 'package:ohayo_post_app/widget/sending_floating_action_button.dart';
import 'package:provider/provider.dart';

class TimeLineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('タイムライン')),
      body: Center(
        child: ListView.builder(
          itemCount: postNtf.posts.length,
          itemBuilder: (BuildContext context, int index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('報告者：${postNtf.posts[index].contributorId}'),
                  Text('今日の目標：${postNtf.posts[index].target}'),
                  Text(
                      '報告日：${Convert().getJapaneseDateFormat(postNtf.posts[index].createdAt)}'),
                  Text(
                      '更新日：${Convert().getJapaneseDateFormat(postNtf.posts[index].updatedAt)}'),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SendingFloatingActionButton(),
    );
  }
}
