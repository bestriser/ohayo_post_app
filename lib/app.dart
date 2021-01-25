import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/person.dart';
import 'package:ohayo_post_app/model/post.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/notifier/person_notifier.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/screen/root/root_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);
    final person = Provider.of<Person>(context);
    final posts = Provider.of<List<Post>>(context);

    /// FirebaseとStream以外のProviderを読み込む
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PersonNotifier.fromPerson(person),
        ),
        ChangeNotifierProvider.value(
          value: PostNotifier.fromPosts(posts),
        ),
      ],
      child: MaterialApp(
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
              return RootScreen();
            }

            // Firebaseのinitializeの完了待ち
            return Container(
              color: Colors.white,
              child: CupertinoActivityIndicator(radius: 25),
            );
          },
        ),
      ),
    );
  }
}
