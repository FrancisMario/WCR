import 'package:flutter/material.dart';
import 'package:wcr/base.dart';
import 'package:wcr/blog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'West Coast Radio',
     
      home: Home(),
    );
  }
}

