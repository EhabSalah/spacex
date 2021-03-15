import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';

import '../ui/screen/home/home_screen.dart';
import '../ui/screen/launch_details/launch_details_screen.dart';
import '../ui/screen/main/main_screen.dart';
import '../ui/screen/next_launch/next_launch_screen.dart';
import '../ui/screen/splash/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen),
    MaterialRoute(page: MainScreen),
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: LaunchDetailsScreen),

    /// main screen
    MaterialRoute(page: NextLaunchScreen),

    /// main screen
  ],
)
class $AppRouter {}

Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return ScaleTransition(scale: animation, child: child);
}
