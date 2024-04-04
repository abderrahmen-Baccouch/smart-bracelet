import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class   QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.title,
    this.iconsSrc = "assets/icons/ios.svg",
    this.colorl = const Color.fromARGB(255, 125, 131, 247),
  }) : super(key: key);

  final String title, iconsSrc;
  final Color colorl;

  @override
  Widget build(BuildContext context) {
   return Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Adjust padding as needed
  decoration: BoxDecoration(
    color: colorl,
    borderRadius: const BorderRadius.all(Radius.circular(16)), // Adjust border radius as needed
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    children: [
      Transform.translate(
        offset: Offset(-15, 0), // Adjust the offset as needed
        child: Image.asset(
          'assets/icons/bracelet.png',
          height: 80, // Adjust the height as needed
          width: 80, // Adjust the width as needed
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "answer me",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "We value your feedback           - 7 Qs",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white60,
                      fontSize: 14, // Adjust font size as needed
                    ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 30, // Adjust the height of the VerticalDivider
        child: VerticalDivider(
          // thickness: 5,
          color: Colors.white70,
        ),
      ),
      const SizedBox(width: 8),
       Transform.translate(
        offset: Offset(-10, 0), 
     child: Icon(
        Iconsax.message_question,  // Replace with your desired icon
        color: Color(0xFFF77D8E), // Icon color
      ),
       ),
    ],
  ),
);

  }
}
