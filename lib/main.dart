import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_expanding_card/expanding_card_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpandingCard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpandingCardExample(),
    );
  }
}
