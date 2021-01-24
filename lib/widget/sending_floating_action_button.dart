import 'package:flutter/material.dart';
import 'package:ohayo_post_app/screen/post/sending_screen.dart';

class SendingFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 70),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SendingScreen(),
            ),
          );
        },
        tooltip: 'NavigatorPushSendingScreen',
        child: Icon(Icons.add),
      ),
    );
  }
}
