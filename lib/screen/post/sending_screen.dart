import 'package:flutter/material.dart';

class SendingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SendingState();
  }
}

class SendingState extends State<SendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 102,
        leading: FlatButton(
          child: Text(
            'キャンセル',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.popUntil(
              context,
              (Route<dynamic> route) => route.isFirst,
            );
          },
        ),
        actions: [
          FlatButton(
            child: Text(
              '投稿する',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
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
                      hintText: 'おはよう報告を投稿しよう！',
                      hintStyle: Theme.of(context).accentTextTheme.bodyText1,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                    ),
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
