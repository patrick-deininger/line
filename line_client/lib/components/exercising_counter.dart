import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingCounter extends StatefulWidget {
  final IconData icon;
  const ExercisingCounter ({ Key? key, required this.icon }): super(key: key);

  @override
  State<StatefulWidget> createState() => _ExercisingCounterState();
}

class _ExercisingCounterState extends State<ExercisingCounter> {
  String label = "abc";

  void setLabel(String text)
  {
    this.label = text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 4),
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
          )),
    );
  }
}
