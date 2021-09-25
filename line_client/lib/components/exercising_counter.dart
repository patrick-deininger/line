import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingCounter extends StatefulWidget {
  final IconData icon;
  final String mode;

  const ExercisingCounter({ Key? key, required this.icon, this.mode = 'heart_rate' }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExercisingCounterState();
}

class _ExercisingCounterState extends State<ExercisingCounter> {
  String label = "";
  int count = 0;
  Random rnd = new Random();
  int minRate = 85;
  int maxRate = 110;
  int last = 93;
  var steps = [-2, -1, -1, 0, 1, 1, 2];

  @override
  void initState() {
    super.initState();
    if (widget.mode == 'heart_rate')
      {
        generateNextHeartRate();
      } else {
      updateCountLabel();
    }
  }


  void setLabel(String text) {
    this.label = text;
  }


  void updateCountLabel()
  {
    setState(() {
      this.label = this.count.toString() + '/5';
    });
  }


  void generateNextHeartRate()
  {
      {
        Future.delayed(const Duration(milliseconds: 1500), () {
          last = min(maxRate, max(minRate, last + steps[rnd.nextInt(steps.length - 1)]));
          updateHeartRateLabel(last);
          generateNextHeartRate();
        });
      }
  }


  void updateHeartRateLabel(int rate)
  {
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
                color: new Color(0xAB7487FF),
                borderRadius: new BorderRadius.all(
                    Radius.circular(20.0)
                )),
            child: new Center(
              child: new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: 24.0,
                      ),
                      Text(
                        this.label,
                        style: GoogleFonts.lato(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )),
            ),
          )
          ),
          onTap: (){
            if (widget.mode == 'count')
              {
                count += 1;
                updateCountLabel();
              }
          }

    )

    );
  }
}
