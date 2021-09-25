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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            this.label,
            style: GoogleFonts.lato(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Text(
            this.secondaryText,
            style: GoogleFonts.lato(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
