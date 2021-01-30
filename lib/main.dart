import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohayo_post_app/initialize.dart';

void main() async {
  // main()の中で非同期処理を行う際には、下記の実行が必須
  WidgetsFlutterBinding.ensureInitialized();

  // Androidのナビゲーションバーのみ表示(ステータスバーは非表示)
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  // iOS,Androidともに縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(Initialize());
    },
  );
}
