import 'package:flutter/material.dart';
import 'package:line_client/components/exercising_counter.dart';
import 'package:line_client/components/exercising_bottom.dart';
import 'package:line_client/components/heading.dart';

class ExerciseOverlay extends StatefulWidget {
  @override
  _ExerciseOverlayState createState() => _ExerciseOverlayState();
}

class _ExerciseOverlayState extends State<ExerciseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Heading(label: 'Squats'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 12.0, left: 24, right: 24),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ExercisingCounter(icon: Icons.bar_chart, mode: 'heart_rate'),
                          ExercisingCounter(icon: Icons.repeat, mode: 'count'),
                        ]),
                  ),
                ],
              ),
              ExercisingBottom(),
            ]));
  }
}
