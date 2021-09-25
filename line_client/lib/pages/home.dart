import 'package:flutter/material.dart';
import 'package:line_client/components/activity_chart.dart';
import 'package:line_client/components/heading.dart';
import 'package:line_client/components/prevention_panel.dart';
import 'package:line_client/components/risk_chart.dart';

class HomePage extends StatefulWidget {
  HomePage(this.apiResponse);

  final List apiResponse;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Heading(label: "Activity"),
              ActivityChart(),
              Heading(label: "Risk"),
              RiskChart(widget.apiResponse),
              Heading(label: "Muscle Load"),
              Image.asset('assets/images/muscle_groups.png'),
              Heading(label: "Your Prevention Plan"),
              PreventionPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
