
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive_animated_login/model/helpers.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String steps = formatNumber(randBetween(3000, 6000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            steps,
            style: const TextStyle(
              fontSize: 30,
              fontFamily:  'Inhiritance',
              fontWeight: FontWeight.w400,
            ),
          ),
           Text(
  'Total Steps',
  style: GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: Color(0xFFF77D8E),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 2,
    ),
  ),
),
        ],
      ),
    );
  }
}