import 'package:flutter/material.dart';


class Styles {
  static ThemeData themeData(bool isLightTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Lato',

      scaffoldBackgroundColor:
          isLightTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      primarySwatch: Colors.purple,
      primaryColor: isLightTheme ? Colors.grey.shade300 : Colors.black,
      accentColor: Colors.deepPurple,
      backgroundColor: isLightTheme ? Colors.white : Colors.grey.shade700,
      indicatorColor:
          isLightTheme ? const Color(0xffCBDCF8) : const Color(0xff0E1D36),
      hintColor: isLightTheme ? Colors.grey.shade800 : Colors.grey.shade300,

      hoverColor:
          isLightTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isLightTheme ? const Color(0xffA8DAB5) : const Color(0xff0B2512),
      disabledColor: Colors.grey,
      textSelectionColor: isLightTheme ? Colors.black : Colors.white,
      cardColor: isLightTheme ? Colors.white : const Color(0xFF151515),
      canvasColor: isLightTheme ? Colors.grey[50] : Colors.black,
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isLightTheme
              ? const ColorScheme.light()
              : const ColorScheme.dark()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Anton'),
        headline3: TextStyle(
          fontWeight: FontWeight.w300,
          color: Color(0xFF023047),
          fontSize: 27,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      //=======================

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            color: isLightTheme ?   Colors.grey.shade500:Colors.grey.shade800),
        filled: true,
        fillColor: isLightTheme ?   const Color(0xffF2F8F8):Colors.grey.shade600,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
