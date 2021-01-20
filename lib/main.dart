import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohayo_post_app/app.dart';
import 'package:ohayo_post_app/counter_notifier.dart';
import 'package:ohayo_post_app/firebase_notifier.dart';
import 'package:ohayo_post_app/user_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  // main()の中で非同期処理を行う際には、下記の実行が必須
  WidgetsFlutterBinding.ensureInitialized();

  // FirebaseとFirebaseAuthenticationの初期設定
  bool isInitialized = false;
  String initializedErrorMessage = '';
  bool isLoggedIn = false;
  String loginErrorMessage = '';

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
          return isLoggedIn = true;
        }
      },
    );
  } catch (e) {
    loginErrorMessage = e;
  }

  // iOS,androidともに縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => FirebaseNotifier()
                ..setIsInitialized(isInitialized)
                ..setInitializedErrorMessage(initializedErrorMessage)
                ..setIsLoggedIn(isLoggedIn)
                ..setLoginErrorMessage(loginErrorMessage),
            ),
            ChangeNotifierProvider(
              create: (_) => UserNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => CounterNotifier(),
            ),
          ],
          child: App(),
        ),
      );
    },
  );
}
