import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohayo_post_app/app.dart';
import 'package:ohayo_post_app/counter.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: App(),
    ),
  );
}
