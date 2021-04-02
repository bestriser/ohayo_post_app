import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/notifier/firebase_notifier.dart';
import 'package:ohayo_post_app/screen/analysis/analysis_screen.dart';
import 'package:ohayo_post_app/screen/login/login_screen.dart';
import 'package:ohayo_post_app/screen/my_page/my_page_screen.dart';
import 'package:ohayo_post_app/screen/registration/registration_screen.dart';
import 'package:ohayo_post_app/screen/time_line/time_line_screen.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseNtf = Provider.of<FirebaseNotifier>(context);

    return !firebaseNtf.isLoggedIn
        ? Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '朝活応援アプリ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'おはようポスト',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('ログイン'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      child: Text('登録'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : CupertinoTabScaffold(
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(
                        child: TimeLineScreen(), // 表示したい画面のWidget
                      );
                    },
                  );
                case 1:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(
                        child: AnalysisScreen(), // 表示したい画面のWidget
                      );
                    },
                  );
                case 2:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(
                        child: MyPageScreen(), // 表示したい画面のWidget
                      );
                    },
                  );
                default:
                  return null;
              }
            },
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.article_outlined),
                  activeIcon: Icon(Icons.article, color: Colors.orange),
                  label: 'タイムライン',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined),
                  activeIcon: Icon(Icons.analytics, color: Colors.orange),
                  label: '分析',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle, color: Colors.orange),
                  label: 'マイページ',
                ),
              ],
            ),
          );
  }
}
