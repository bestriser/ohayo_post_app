import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/utility/convert.dart';
import 'package:ohayo_post_app/widget/posting_floating_action_button.dart';
import 'package:provider/provider.dart';

class TimeLineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('タイムライン')),
      floatingActionButton: PostingFloatingActionButton(),
      body: FutureBuilder(
        future: postNtf.setContributorData(postNtf.posts),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 「posts」の取得エラー
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: AlertDialog(
                  title: Text(
                    'サーバーの接続中にエラーが発生しました...\nアプリを再起動して下さい！\nposts：[${postNtf.posts}]',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }

          // postsとcontributorDataの紐付け完了
          if (snapshot.connectionState == ConnectionState.done)
            return Center(
              child: postNtf.posts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '右下の＋ボタンから\nおはようポストしてみよう',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: postNtf.posts.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 48,
                                    width: 48,
                                    child: Image.network('https://2.bp.blogspot.com/-RukBNDsJmYw/WD_cYZlBoSI/AAAAAAABAEs/'
                                        'ddSv5AT9KgcVmt0RV9VewmNfvqOjETpMwCLcB/s300/sun_yellow2_character.png'),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${postNtf.posts[index].contributorData.nickName}'),
                                      Text('${Convert().getYearMonthDayWeekDayHourMinute(postNtf.posts[index].createdAt)}'),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(thickness: 1, color: Colors.grey),
                              Text('✨ 今朝の気持ち ✨'),
                              const SizedBox(height: 8),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('${postNtf.posts[index].feeling}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            );

          // postsとcontributorDataの紐付け待ち
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
          );
        },
      ),
    );
  }
}
