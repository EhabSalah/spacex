import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';
import '../color.dart';

/// The `displayColor` is applied to [headline4], [headline3], [headline2],
/// [headline1], and [caption]. The `bodyColor` is applied to the remaining
/// text styles.
TextTheme textTheme = ThemeData.light().textTheme.copyWith().apply(
      bodyColor: textSecondary, // bodyText1 (secondary text color)
      displayColor: textPrimary, // caption ( primary text color)
      fontFamily: FontFamily.almerai,
    );
