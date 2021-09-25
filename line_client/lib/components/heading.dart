import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  Heading({required this.label, this.secondaryText = ''});

  final String label;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.label,
            style: GoogleFonts.lato(
              color: Color(0xff454545),
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Text(
            this.secondaryText,
            style: GoogleFonts.lato(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingPlusColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Fitness",
            style: GoogleFonts.lato(
              color: Color(0xff23b6e6),
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Text(
            "vs",
            style: GoogleFonts.lato(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Text(
            "Risk",
            style: GoogleFonts.lato(
              color: Color(0xffd3029a),
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
