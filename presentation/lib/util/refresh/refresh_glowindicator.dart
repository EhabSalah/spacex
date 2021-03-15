import 'package:flutter/material.dart';

// Under the default condition of not customizing,
// a halo will appear when you drag to the top and can no longer drag,
// if you only want to see the halo when you hit the top
// The following example can solve this problem

// Android platform custom refresh halo effect
class RefreshScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // When modifying this function, consider modifying the implementation in
    // _MaterialScrollBehavior as well.
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          child: child,
          // this will disable top Bouncing OverScroll
          // Indicator showing in Android
          showLeading: true,
          //Whether the top water ripple is displayed
          showTrailing: true,
          //Whether the bottom water ripple is displayed
          axisDirection: axisDirection,
          notificationPredicate: (notification) {
            if (notification.depth == 0) {
              // There is no need to display water ripples
              // if the overScroll is triggered by dragging beyond the boundary
              if (notification.metrics.outOfRange) {
                return false;
              }
              return true;
            }
            return false;
          },
          color: Theme.of(context).primaryColor,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
    }
    return null;
  }
}
