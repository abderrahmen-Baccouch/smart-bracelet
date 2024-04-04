import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Stats(value: '345', unit: 'kcal', label: 'Calories'),
        Stats(value: '3.6', unit: 'km', label: 'Distance'),
        Stats(value: '1.5', unit: 'hr', label: 'Hours'),
      ],
    );
  }
}

class Stats extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const Stats({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
              text: value,
             style: GoogleFonts.poppins(
  textStyle: const TextStyle(
    color :Color(0xFFF77D8E),
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
),

              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: unit,
                  style: GoogleFonts.montserrat(
  textStyle: const TextStyle(
    fontSize: 10,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w500,
  ),
),
                ),
              ]),
        ),
        
        Text(
          label,
           style: GoogleFonts.montserrat(
  textStyle: const TextStyle(
    fontSize: 10,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w500,
  ),),
        ),
      ],
    );
  }
}