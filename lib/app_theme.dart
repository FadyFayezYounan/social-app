import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
/// NAME       SIZE   WEIGHT   SPACING  2018 NAME
/// display4   112.0  thin     0.0      headline1
/// display3   56.0   normal   0.0      headline2
/// display2   45.0   normal   0.0      headline3
/// display1   34.0   normal   0.0      headline4
/// headline   24.0   normal   0.0      headline5
/// title      20.0   medium   0.0      headline6
/// subhead    16.0   normal   0.0      subtitle1
/// body2      14.0   medium   0.0      body1 (bodyText1)
/// body1      14.0   normal   0.0      body2 (bodyText2)
/// caption    12.0   normal   0.0      caption
/// button     14.0   medium   0.0      button
/// subtitle   14.0   medium   0.0      subtitle2
/// overline   10.0   normal   0.0      overline
class AppTheme {

  static Color appPrimaryColor = Color(0xFF7737FF);

  static Color lightAccentColor = Color(0xFF3B516E);
  static Color lightScaffoldBackgroundColor = Color(0xFFF5F9FF);


  static Color darkAccentColor = Colors.white;
  static Color darkScaffoldBackgroundColor = Colors.black;

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Quicksand',
      primarySwatch: Colors.deepPurple,
      primaryColor: appPrimaryColor,
      accentColor: lightAccentColor,
      scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      colorScheme: ColorScheme.light(),
      appBarTheme: AppBarTheme(
        backgroundColor: lightScaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: appPrimaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Pacifico',
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  lightScaffoldBackgroundColor,//Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),

      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: lightAccentColor,
          fontSize: 12.sp,
        ),
        bodyText2: TextStyle(
          color: lightAccentColor.withOpacity(0.5),
          fontSize: 12.sp,
        ),
        overline: TextStyle(
          color: lightAccentColor,
          fontSize: 14.sp,
        ),
        headline6: TextStyle(
          color: lightAccentColor,
          //fontWeight: FontWeight.w900,
          fontSize: 20.sp,
        ),
        headline5: TextStyle(
          color: lightAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 28.sp,
        ),
        subtitle1: TextStyle(
          color: lightAccentColor,
          fontSize: 16.sp,
        ),
      ),


    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Quicksand',
      primarySwatch: Colors.deepPurple,
      primaryColor: appPrimaryColor,
      accentColor: darkAccentColor,
      scaffoldBackgroundColor: darkScaffoldBackgroundColor,
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: darkScaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: appPrimaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Pacifico',
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  darkScaffoldBackgroundColor,//Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),

      ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: darkAccentColor,
            fontSize: 12.sp,
          ),
          bodyText2: TextStyle(
            color: darkAccentColor.withOpacity(0.5),
            fontSize: 12.sp,
          ),
          headline6: TextStyle(
            color: darkAccentColor,
            //fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
          headline5: TextStyle(
            color: darkAccentColor,
            fontWeight: FontWeight.w900,
            fontSize: 28.sp,
          ),
          subtitle1: TextStyle(
            color: darkAccentColor,
            fontSize: 16.sp,
          ),
        ),
    );
  }
}
