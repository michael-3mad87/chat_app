import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor =  Color(0xff3598DB);

  static const Color grey = Color.fromARGB(255, 151, 153, 156);
  static const Color red = Color(0xffEC4B4B);
  static const Color green = Color(0xff61E757);
  static const Color white = Color(0xffffffff);
  static const Color lightGrey = Color.fromARGB(255, 217, 214, 214);

  static Color black = const Color(0xff060E1E);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme:const AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: white)),
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(width: 4, color: primaryColor),
      ),
      iconSize: 35,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleSmall:
          TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
      labelSmall:
          TextStyle(color: grey, fontSize: 15, fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
      ),
    ),
  );
}
