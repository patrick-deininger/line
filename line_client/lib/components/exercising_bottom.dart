import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingBottom extends StatelessWidget {
  ExercisingBottom();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 100,
            decoration: new BoxDecoration(
                color: new Color(0xAB7487FF),
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                )),


          /*child: Text('go down'),*/
        ),
      ),
    );
  }
}
