import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);

    return MaterialApp(
      title: 'おはようポスト',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      // DynamicTypeを無効
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child,
        );
      },
      home: Builder(
        builder: (context) {
          // 「Firebase.initializeApp()」or「FirebaseAuth.instance()」のエラー
          if (firebaseNtf.initializedErrorMessage.isNotEmpty ||
              firebaseNtf.loginErrorMessage.isNotEmpty) {
            return Container(
              color: Colors.white,
              child: Center(
                child: AlertDialog(
                  title: Text(
                    'サーバーの接続中にエラーが発生しました...' +
                        '\nアプリを再起動して下さい！' +
                        '\ninitializedErrorMessage：[${firebaseNtf.initializedErrorMessage}]' +
                        '\nloggedInErrorMessage：[${firebaseNtf.loginErrorMessage}]',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }

          // Firebaseのinitializeの完了後
          if (firebaseNtf.isInitialized) {
            return HomeScreen('おはようポスト');
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
