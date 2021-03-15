import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'navigation_tabs.dart';

class NavigationStateNotifier extends StateNotifier<int> {
  NavigationStateNotifier() : super(NavigationTabs.pastLaunches);

  // ignore: use_setters_to_change_properties
  void change(int index) => state = index;

  Future<bool> onWillPop() async {
    final currentNavigatorState = ExtendedNavigator.named(tabs[state].name);

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
    } else {
      if (state == NavigationTabs.pastLaunches) {
        return true;
      } else {
        state = NavigationTabs.pastLaunches;
      }
    }

    return false;
  }
}

final navigationProvider =
    StateNotifierProvider.autoDispose((ref) => NavigationStateNotifier());
