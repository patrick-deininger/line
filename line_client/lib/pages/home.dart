import 'package:flutter/material.dart';
import 'package:line_client/components/activity_chart.dart';
import 'package:line_client/components/risk_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Line"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ActivityChart(),
            RiskChart(),
          ],
        ),
      ),
    );
  }
}
