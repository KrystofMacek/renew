import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color colorWhiteBlue = Color(0xffC9E2FD);
const Color accentColorYellow = Color(0xffFFCF00);
const Color accentColorYellowLight = Color(0xffFFE264);
const Color shadow = Color(0xff455a64);
const Color lightPrimary = Color(0xff5FABFF);
const Color primaryBlue = Color(0xff1483FF);

ThemeData getBaseTheme() {
  return ThemeData(
    primaryColor: primaryBlue,
    primaryColorLight: lightPrimary,
    accentColor: accentColorYellow,
    scaffoldBackgroundColor: Color(0xff1483FF),
    iconTheme: IconThemeData(
      color: Color(0xffFFFDF6),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 78,
        color: colorWhiteBlue,
        fontWeight: FontWeight.w100,
        shadows: [
          BoxShadow(
            color: shadow,
            spreadRadius: 4,
            blurRadius: 7,
          )
        ],
      ),
      headline2: TextStyle(
        fontFamily: 'Comfortaa',
        color: accentColorYellowLight,
        fontSize: 44,
        fontWeight: FontWeight.w200,
      ),
      headline3: TextStyle(
        fontFamily: 'CourierPrime',
        color: accentColorYellow,
        fontSize: 44,
        fontWeight: FontWeight.w200,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Comfortaa',
        color: colorWhiteBlue,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Comfortaa',
        color: shadow,
        fontSize: 18,
        fontWeight: FontWeight.w200,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Comfortaa',
        color: accentColorYellow,
        fontSize: 22,
      ),
      button: TextStyle(
        fontFamily: 'Comfortaa',
        color: shadow,
        fontSize: 24,
        letterSpacing: 2,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

abstract class CustomDecoration {
  static InputDecoration getInputDecoration(String hint) => InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        hintText: hint,
        isDense: true,
        fillColor: colorWhiteBlue,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFFCF00), width: 0.1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFFCF00), width: 1.0),
        ),
      );
}
