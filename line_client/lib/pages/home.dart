import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_client/components/activity_chart.dart';
import 'package:line_client/components/heading.dart';
import 'package:line_client/components/line_logo.dart';
import 'package:line_client/components/prevention_panel.dart';
import 'package:line_client/components/risk_chart.dart';
import 'package:line_client/utils/activity_api.dart';

class HomePage extends StatefulWidget {
  HomePage(this.apiResponse, this.activities);

  final List apiResponse;
  final List<Activity> activities;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LineLogo(),
              Container(
                padding: EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: Text(
                  "There is a small line between fit and f*cked.",
                  style: GoogleFonts.lato(
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Heading(
                label: "Activity",
                secondaryText: 'Updated seconds ago',
              ),
              ActivityChart(widget.activities),
              Heading(label: "Risk"),
              RiskChart(widget.apiResponse),
              SizedBox(height: 16),
              Heading(label: "Muscle Load"),
              SizedBox(height: 8),
              Image.asset('assets/images/muscle_groups.png'),
              SizedBox(height: 16),
              Heading(label: "Your Prevention Plan"),
              PreventionPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
