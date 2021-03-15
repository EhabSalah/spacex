import 'package:flutter/material.dart';

import '../../../../router/router.gr.dart';
import 'tab.dart';

class NavigationTabs {
  /// Default constructor is private because this class will be only used for
  /// static fields and you should not instantiate it.
  NavigationTabs._();

  static const pastLaunches = 0;
  static const nextLaunch = 1;
}

final tabs = const <NavigationTab>[
  NavigationTab(
    name: 'Past',
    icon: Icons.flight,
    activeIcon: Icons.flight,
    initialRoute: Routes.homeScreen,
    index: NavigationTabs.pastLaunches,
  ),
  NavigationTab(
    name: 'Next',
    icon: Icons.flight_takeoff_sharp,
    activeIcon: Icons.flight_takeoff_sharp,
    initialRoute: Routes.nextLaunchScreen,
    index: NavigationTabs.nextLaunch,
  ),
];
