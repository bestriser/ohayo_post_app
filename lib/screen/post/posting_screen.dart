import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/person_notifier.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:provider/provider.dart';

class PostingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostingState();
  }
}

class PostingState extends State<PostingScreen> {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);
    final personNtf = Provider.of<PersonNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 102,
        leading: TextButton(
          child: Text(
            'キャンセル',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'ポストする',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await postNtf.submitPost(personNtf.person.uid);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
                  child: TextField(
                    autofocus: true,
                    maxLines: 12,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: '今朝の気持ちをポストしよう！',
                      hintStyle: Theme.of(context).accentTextTheme.bodyText1,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                    ),
                    onChanged: postNtf.setTarget,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
