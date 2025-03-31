import 'package:flutter/material.dart';
import 'package:ncell_test/HomeWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WebViewPlatform.instance ??= WebViewPlatform.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: HomeWidget());
  }
}
