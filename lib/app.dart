import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おはようポスト',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // エラー時
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: AlertDialog(
                  title: Text(
                    'サーバーの接続中にエラーが発生しました...\nアプリを再起動して下さい！',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }

          // Firebaseのinitializeの完了後
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen(title: 'おはようポスト');
          }

          // Firebaseのinitializeの完了待ち
          return Container(
            color: Colors.white,
            child: CupertinoActivityIndicator(radius: 25),
          );
        },
      ),
    );
  }
}
