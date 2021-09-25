import 'package:flutter/material.dart';
import 'package:line_client/components/exercising_counter.dart';
import 'package:line_client/components/heading.dart';

class ExerciseOverlay extends StatefulWidget {
  @override
  _ExerciseOverlayState createState() => _ExerciseOverlayState();
}

class _ExerciseOverlayState extends State<ExerciseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Heading(label: 'Squats'),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 10.0, left: 24, right: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ExercisingCounter(label: '108', icon: Icons.bar_chart),
                    ExercisingCounter(label: '#2/10', icon: Icons.repeat),
                  ]),
            )
          ],
        ));
  }
}
