import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backgroundLight = Color(0xffDFECDB);
  static Color black = Color(0xff383838);
  static Color white = Color(0xffffffff);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xffC8C9CB);
  static Color backgroundDark = Color(0xff060E1E);
  static Color blackDrk = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryLight, toolbarHeight: 85, elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: primaryLight,
      unselectedItemColor: greyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        shape: StadiumBorder(side: BorderSide(color: white, width: 4))),
    textTheme: TextTheme(
      titleLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
      titleMedium:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
      titleSmall:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        elevation: 0,
        toolbarHeight: 15,
        iconTheme: IconThemeData(color: redColor)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: redColor,
      unselectedItemColor: white,
    ),
    textTheme: TextTheme(
      titleLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
      titleMedium:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: white),
      titleSmall:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: redColor),
    ),
  );
}
