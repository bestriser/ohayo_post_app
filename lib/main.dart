import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohayo_post_app/app.dart';
import 'package:ohayo_post_app/data_service/person_data_service.dart';
import 'package:ohayo_post_app/data_service/post_data_service.dart';
import 'package:ohayo_post_app/model/person.dart';
import 'package:ohayo_post_app/model/post.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  // main()の中で非同期処理を行う際には、下記の実行が必須
  WidgetsFlutterBinding.ensureInitialized();

  // FirebaseとFirebaseAuthenticationの初期設定
  bool isInitialized = false;
  String initializedErrorMessage = '';
  bool isLoggedIn = false;
  String loginErrorMessage = '';
  String firebaseUid = '';

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
          return isLoggedIn = true;
        }
      },
    );
  } catch (e) {
    loginErrorMessage = e;
  }

  // Androidのナビゲーションバーのみ表示(ステータスバーは非表示)
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  // iOS,Androidともに縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        /// FirebaseとStreamのProviderを読み込む
        MultiProvider(
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
              initialData: Person.empty(),
            ),
            StreamProvider<List<Post>>.value(
              value: PostDataService().postStream(firebaseUid),
              initialData: const <Post>[],
            ),
          ],
          child: App(),
        ),
      );
    },
  );
}
