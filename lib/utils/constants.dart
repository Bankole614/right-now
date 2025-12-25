import 'package:flutter/material.dart';


class Constants {
  static const String baseUrl = 'https://core.hisend.hunnovate.com/api';
  static const Color kPrimaryBlue = Color(0xFF283593);
}

const Color kPrimaryBlue = Color(0xFF283593);
const Color kSecondaryBlue = Color(0xFF030A58);
const Color kAccentBlue = Color(0xFF1D4ED8);
const double kRadius = 12.0;
const double kPadding = 20.0;
const Color kNavBarGrey = Color(0xFFF5F5F5);
const Color kInactiveGrey = Color(0xFF9E9E9E);
const Color kGradientStart = Color(0xFF1D8ADF);
const Color kGradientEnd = Color(0xFF283593);
// Consider defining dark mode specific constants
const Color kDarkBackground = Color(0xFF121212);
const Color kDarkSurface = Color(0xFF1E1E1E);
const Color kDarkText = Colors.white;

BoxDecoration kBlueGradient(double radius) => BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E88E5), Color(0xFF283593)],
  ),
  borderRadius: BorderRadius.circular(radius),
);
