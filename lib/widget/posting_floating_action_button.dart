import 'package:flutter/material.dart';
import 'package:ohayo_post_app/screen/post/posting_screen.dart';

class PostingFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 70),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostingScreen(),
            ),
          );
        },
        tooltip: 'NavigatorPushPostingScreen',
        child: Icon(Icons.add),
      ),
    );
  }
}
