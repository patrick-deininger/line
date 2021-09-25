import 'package:flutter/material.dart';
import 'package:line_client/components/activity_chart.dart';
import 'package:line_client/components/heading.dart';
import 'package:line_client/components/prevention_panel.dart';
import 'package:line_client/components/risk_chart.dart';

class HomePage extends StatefulWidget {
  Map<String, num> activeMap;
  HomePage(this.activeMap);

  @override
  _HomePageState createState() => _HomePageState(this.activeMap);
}

class _HomePageState extends State<HomePage> {
  Map<String, num> activeMap;
  _HomePageState(this.activeMap);

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
              ActivityChart(this.activeMap),
              Heading(label: "Risk"),
              RiskChart(),
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
