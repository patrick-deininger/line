import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExercisingBottomState();
}

class _ExercisingBottomState extends State<ExercisingBottom> {
  var instructions = [
    'Start standing with feet about shoulder-width apart',
    'Point toes slightly outward',
    'Always keep back straight',
    'Always keep hands off body',
    'Lower down until hips below knees'
  ];
  int idx = 0;

  String instruction = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      instruction = instructions[0];
    });
  }

  void getNextInstruction() {
    if (idx >= instructions.length - 1) {
      idx = 0;
    } else {
      idx += 1;
    }
    setState(() {
      instruction = instructions[idx];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                color: new Color(0xFF4C8BF5),
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                )),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          'Next step:',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ))
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            this.instruction,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ))
                        ])
                  ],
                ))),
        onTap: () {
          getNextInstruction();
        },
      ),
    );
  }
}
