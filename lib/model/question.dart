import 'package:flutter/material.dart' show Color;

class question {
  final String title, description, iconSrc;
  final Color color;

  question({
    required this.title,
    this.description = 'Build and animate an iOS app from scratch',
    this.iconSrc = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<question> courses = [
  question(
    title: "TITLE",
  ),
  question(
    title: "TITLE",
    iconSrc: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<question> recentCourses = [
  question(title: "TITLE"),
  question(
    title: "TITLE",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  question(title: "TITLE"),
  question(
    title: "TITLE",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
];
