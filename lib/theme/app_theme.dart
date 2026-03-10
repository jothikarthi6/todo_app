import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const darkBg = Color(0xFF1A1B2E);
  static const cardBg = Color(0xFFFFFFFF);
  static const primaryBlue = Color(0xFF3D5AF1);
  static const accentBlue = Color(0xFF0ACDFF);
  static const textDark = Color(0xFF1A1B2E);
  static const textGrey = Color(0xFF9E9E9E);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: darkBg,
  );
}