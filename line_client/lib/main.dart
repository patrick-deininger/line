import 'package:flutter/material.dart';
import 'package:line_client/pages/home.dart';

void main() {
  runApp(LineClient());
}

class LineClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
