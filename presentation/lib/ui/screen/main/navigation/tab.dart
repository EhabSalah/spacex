import 'package:flutter/material.dart';

@immutable
class NavigationTab {
  const NavigationTab({
    this.name,
    this.icon,
    this.activeIcon,
    this.initialRoute,
    this.index,
  });

  final String name;
  final IconData icon;
  final IconData activeIcon;
  final String initialRoute;
  final int index;
}
