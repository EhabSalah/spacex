import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../res/color.dart';
import '../../../router/router.gr.dart';
import 'navigation/navigation_state_notifier.dart';
import 'navigation/navigation_tabs.dart';
import 'navigation/tab.dart';

class MainScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationStateNotifier = useProvider(navigationProvider);
    final state = useProvider(navigationProvider.state);


    return WillPopScope(
      onWillPop: navigationStateNotifier.onWillPop,
      child: Scaffold(
        // drawer: NavigationDrawer(),
        body: IndexedStack(
          index: state,
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            return TickerMode(
              enabled: index == state,
              child: Offstage(
                offstage: index != state,
                child: ExtendedNavigator(
                  initialRoute: tab.initialRoute,
                  name: tab.name,
                  router: AppRouter(),
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 58,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tabs
                  .map((e) => buildIcon(context, e,
                      onChange: navigationStateNotifier.change,
                      currentIndex: state))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIcon(BuildContext context, NavigationTab tab,
      {int currentIndex, Function onChange}) {
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          tab.icon,
          color: currentIndex == tab.index ? colorBlue : Colors.grey.shade400,
          size: currentIndex == tab.index ? 21 : 20,
        ),
        SizedBox(height: 4),
        Text(
          tab.name,
          style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: currentIndex == tab.index ? 11 : 10, height: 1),
        ),
      ],
    );

    return Container(
      child: IconButton(
        onPressed: () => onChange(tab.index),
        padding: EdgeInsets.all(0),
        icon: content,
      ),
    );
  }
}
