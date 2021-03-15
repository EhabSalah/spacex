import 'package:flutter/material.dart';

import '../color.dart';

final floatingActionButtonTheme = ThemeData.light()
    .floatingActionButtonTheme
    .copyWith(backgroundColor: floatingActionButtonColor);

// button theme
final buttonTheme = ButtonThemeData(
  buttonColor: colorButton,
  textTheme: ButtonTextTheme.accent, //  <-- this auto selects the right color
  colorScheme: ThemeData.light().colorScheme.copyWith(secondary: Colors.white),
);