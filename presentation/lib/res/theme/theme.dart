import 'package:flutter/material.dart';

import '../color.dart';
import 'app_bar.dart';
import 'bottom_bar.dart';
import 'button.dart';
import 'text.dart';

ThemeData get lightTheme {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textTheme: textTheme,
    highlightColor: highlightColor,
    appBarTheme: appBarTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: accentColor,
    floatingActionButtonTheme: floatingActionButtonTheme,
    dividerColor: dividerColor,
    errorColor: errorColor,
    hintColor: textSecondary,
    primaryColor: primaryColor,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    buttonTheme: buttonTheme,
    cursorColor: cursor,
    textSelectionHandleColor: textSelectionHandle,
    textSelectionColor: textSelection,
  );
}
