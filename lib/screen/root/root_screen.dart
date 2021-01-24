import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/screen/analysis/analysis_screen.dart';
import 'package:ohayo_post_app/screen/home/home_screen.dart';
import 'package:ohayo_post_app/screen/my_page/my_page_screen.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: HomeScreen('タイムライン'), // 表示したい画面のWidget
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: AnalysisScreen('分析'), // 表示したい画面のWidget
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: MyPageScreen('自分'), // 表示したい画面のWidget
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
