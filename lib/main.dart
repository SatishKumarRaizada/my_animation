import 'package:flutter/material.dart';
import 'package:my_anime/animated_list.dart';
import 'package:my_anime/infinite_scroll_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const AnimatedScrollPage(),
    );
  }
}
