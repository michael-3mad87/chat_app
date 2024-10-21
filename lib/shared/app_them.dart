import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff3598DB);

  static Color grey = const Color.fromARGB(255, 151, 153, 156);
  static Color red = const Color(0xffEC4B4B);
  static Color green = const Color(0xff61E757);
  static Color white = const Color(0xffffffff);

  static Color black = const Color(0xff060E1E);

  static ThemeData lightTheme = ThemeData(
    
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: white)
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
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
        fontSize: 20 ,
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
