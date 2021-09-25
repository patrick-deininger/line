import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisingCounter extends StatelessWidget {
  ExercisingCounter({required this.label, required this.icon});

  final String label;
  final IconData icon;

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
                color: Colors.grey,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                )),
            child: new Center(
              child: new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        this.icon,
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
