import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingCounter extends StatefulWidget {
  final IconData icon;
  final String mode;

  const ExercisingCounter(
      {Key? key, required this.icon, this.mode = 'heart_rate'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExercisingCounterState();
}

class _ExercisingCounterState extends State<ExercisingCounter>
    with TickerProviderStateMixin {
  String label = "";
  int count = 0;
  Random rnd = new Random();
  int minRate = 85;
  int maxRate = 110;
  int last = 93;
  var steps = [-2, -1, -1, 0, 1, 1, 2];

  late AnimationController motionController;
  late Animation motionAnimation;
  double size = 20;
  void initState() {
    super.initState();
    motionController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.75,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    if (widget.mode == 'count') {
      updateCountLabel();
    } else {
      updateHeartRateLabel(last);
      generateNextHeartRate();

      motionController.forward();
      motionController.addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            motionController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            motionController.forward();
          }
        });
      });

      motionController.addListener(() {
        setState(() {
          size = motionController.value * 25;
        });
      });
    }
    // motionController.repeat();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  void updateCountLabel() {
    setState(() {
      this.label = this.count.toString() + '/5';
    });
  }

  void generateNextHeartRate() {
    {
      Future.delayed(const Duration(milliseconds: 1500), () {
        last = min(
            maxRate, max(minRate, last + steps[rnd.nextInt(steps.length - 1)]));
        updateHeartRateLabel(last);
        generateNextHeartRate();
      });
    }
  }

  void updateHeartRateLabel(int rate) {
    setState(() {
      this.label = rate.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8, top: 4),
        child: new GestureDetector(
            child: new Container(
                height: 50.0,
                width: 100.0,
                color: Colors.transparent,
                child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black45,
                        width: 1,
                      ),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(20.0))),
                  child: new Center(
                    child: new Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              widget.icon,
                              size: size,
                              color: Colors.black38,
                            ),
                            Text(
                              this.label,
                              style: GoogleFonts.lato(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )),
                  ),
                )),
            onTap: () {
              if (widget.mode == 'count') {
                count += 1;
                updateCountLabel();
              }
            }));
  }
}
