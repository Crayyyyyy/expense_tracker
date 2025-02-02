import 'package:expense_tracker/pageExpense/pageExpenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2b2d42));
var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          elevation: 1,
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        ),
        inputDecorationTheme: InputDecorationTheme().copyWith(
            labelStyle: TextStyle(color: kDarkColorScheme.onPrimaryContainer)),
      ),
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          elevation: 2,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          elevation: 1,
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 20,
          ),
        ),
        colorScheme: kColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: PageExpenses(),
    ),
  );
}

// PALLETE:
// Black:     #2b2d42
// Gray:      #8d99ae
// White:     #edf2f4
// LightRed:  #ef233c
// DarkRed:   #d90429
