import 'package:flutter/material.dart';

import '../color.dart';
import '../style.dart';

AppBarTheme appBarTheme = AppBarTheme(
  color: appBarColor,
  brightness: Brightness.light,
  textTheme: TextTheme(
    // center text style
    headline6: appBarTextStyle.copyWith(color: appBarTextColor),
    // Side text style
    bodyText2: appBarTextStyle.copyWith(color: appBarTextColor),
  ),
  iconTheme: IconThemeData(
    color: appBarIconsColor,
  ),
);
