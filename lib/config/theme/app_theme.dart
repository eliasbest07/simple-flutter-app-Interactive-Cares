import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const seedColor = Color.fromARGB(255, 8, 107, 79);

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seedColor,
    listTileTheme: const ListTileThemeData(iconColor: seedColor),
    secondaryHeaderColor:const Color.fromARGB(155, 49, 233, 181),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates(), 
      titleMedium: GoogleFonts.comfortaa(), 
    )
    );
}
