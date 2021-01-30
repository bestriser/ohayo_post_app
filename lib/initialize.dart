import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/app.dart';
import 'package:ohayo_post_app/data_service/person_data_service.dart';
import 'package:ohayo_post_app/data_service/post_data_service.dart';
import 'package:ohayo_post_app/model/person.dart';
import 'package:ohayo_post_app/model/post.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:provider/provider.dart';

class Initialize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseとFirebaseAuthenticationの初期設定
    bool isInitialized = false;
    String initializedErrorMessage = '';
    bool isLoggedIn = false;
    String loginErrorMessage = '';
    String firebaseUid = '';

    // ignore: non_constant_identifier_names
    Future<void> FirebaseInitializeAndAuthCheck() async {
      try {
        await Firebase.initializeApp();
        isInitialized = true;
      } catch (e) {
        initializedErrorMessage = e;
      }

      try {
        FirebaseAuth.instance.authStateChanges().listen(
          (User user) {
            if (user != null) {
              firebaseUid = user.uid;
              isLoggedIn = true;
            }
          },
        );
      } catch (e) {
        loginErrorMessage = e;
      }
    }

    // FirebaseとStream以外のProviderの読み込み
    return FutureBuilder(
      future: FirebaseInitializeAndAuthCheck(),
      builder: (context, snapshot) {
        // 「Firebase.initializeApp()」or「FirebaseAuth.instance()」のエラー
        if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: AlertDialog(
                title: Text(
                  'サーバーの接続中にエラーが発生しました...' +
                      '\nアプリを再起動して下さい！' +
                      '\ninitializedErrorMessage：[$initializedErrorMessage]' +
                      '\nloggedInErrorMessage：[$loginErrorMessage]',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }

        // Firebaseのinitializeの完了後
        if (snapshot.connectionState == ConnectionState.done) {
          // StreamのProviderを読み込む
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => FirebaseNotifier()
                  ..setIsInitialized(isInitialized)
                  ..setInitializedErrorMessage(initializedErrorMessage)
                  ..setIsLoggedIn(isLoggedIn)
                  ..setLoginErrorMessage(loginErrorMessage),
              ),
              StreamProvider<Person>.value(
                value: PersonDataService().personStream(firebaseUid),
              ),
              StreamProvider<List<Post>>.value(
                value: PostDataService().postStream(firebaseUid),
              ),
            ],
            child: App(),
          );
        }

        // Firebaseのinitializeの完了待ち
        return Container(
          color: Colors.white,
          child: CupertinoActivityIndicator(radius: 25),
        );
      },
    );
  }
}
