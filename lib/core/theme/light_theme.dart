import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/theme/page_transitions.dart';
import 'package:hive_game_client/core/theme/text_theme.dart';

///Theme Light
final ThemeData themeLight = ThemeData(
  errorColor: const Color(0xffFF6666),
  // cupertinoOverrideTheme: CupertinoThemeData(),
  primaryIconTheme: const IconThemeData(
    color: Colors.black,
  ),
  brightness: Brightness.light,
  textTheme: textLightTheme,
  splashFactory: InkRipple.splashFactory,
  canvasColor: const Color(0xFFE9E8E8),
  // textTheme: textTheme,
  // platform: TargetPlatform.android,
  cardColor: const Color(0xffF9F9F9),

  // cardTheme: const CardTheme(
  //   color: Color(0xffF9F9F9),
  //   elevation: 0,
  // ),685639373
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFFA79FD7),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xff3EE78A),
      tabLabelTextStyle: TextStyle(
        fontSize: 10,
        color: black,
        fontFamily: 'PNBold',
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFFA79FD7),
  ),

  dividerColor: const Color(0xffD2D2D2),
  fontFamily: 'PNRegular',
  primaryColor: const Color(0xFFA79FD7),
  // tabBarTheme: tabBarThemeLight,

  dividerTheme: const DividerThemeData(
    color: Color(0xffF9F9F9),
    thickness: 0.5,
    indent: 16,
    endIndent: 16,
  ),
  iconTheme: iconThemeDataLight,
  appBarTheme: appBarThemeLight,
  inputDecorationTheme: const InputDecorationTheme(
    filled: false,
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFA79FD7),
      ),
    ),
    labelStyle: TextStyle(
      fontSize: 16,
      color: black,
      fontFamily: 'PNRegular',
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontFamily: 'PNRegular',
    ),
  ),

  pageTransitionsTheme: pageTransitions,
  backgroundColor: Colors.white,
  bottomAppBarTheme: bottomAppBarThemeLight,
  // cupertinoOverrideTheme: CupertinoTheme(),

  colorScheme: ColorScheme.fromSwatch(
    accentColor: const Color(0xFF84DCE3),
    primarySwatch: const MaterialColor(
      400,
      {
        100: Color(0xFFA79FD7),
        200: Color(0xFFA79FD7),
        300: Color(0xFFA79FD7),
        400: Color(0xFFA79FD7),
        500: Color(0xFFA79FD7),
        600: Color(0xFFA79FD7),
        700: Color(0xFFA79FD7),
        800: Color(0xFFA79FD7),
        900: Color(0xFFA79FD7),
      },
    ),
    // primary: orange,
  ),
);

BottomAppBarTheme bottomAppBarThemeLight = const BottomAppBarTheme(
  color: Colors.transparent,
  elevation: 0.5,
);
AppBarTheme appBarThemeLight = const AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  foregroundColor: Colors.black,
);

IconThemeData iconThemeDataLight = const IconThemeData(
  color: Colors.black,
  size: 24,
);
