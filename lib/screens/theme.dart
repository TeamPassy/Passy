import 'package:flutter/material.dart';

const entryPadding = EdgeInsets.symmetric(vertical: 8, horizontal: 8);
const appBarButtonSplashRadius = 28.0;
const appBarButtonPadding = EdgeInsets.all(16.0);

final ShapeBorder dialogShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12.0),
);
final darkContentColor = Colors.blueGrey[900]!;
final darkContentSecondaryColor = Colors.blueGrey[600]!;
final lightContentColor = Colors.blue[50]!;
final lightContentSecondaryColor = Colors.blue[200]!;

final theme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.purple[900]!,
    onPrimary: lightContentColor,
    secondary: Colors.purple[700]!,
    onSecondary: lightContentColor,
    onSurface: lightContentColor,
  ),
  snackBarTheme: SnackBarThemeData(actionTextColor: Colors.blueGrey[900]),
  scaffoldBackgroundColor: darkContentColor,
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: lightContentSecondaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        color: darkContentSecondaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: lightContentColor)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shadowColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lightContentColor,
    selectionColor: lightContentSecondaryColor,
    selectionHandleColor: lightContentColor,
  ),
);
