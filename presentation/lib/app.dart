import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'res/theme/theme.dart';
import 'router/router.gr.dart';
import 'util/refresh/refresh_glowindicator.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) => false,
      child: MaterialApp(
        title: 'SpaceX',
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator.builder<AppRouter>(
          router: AppRouter(),
          initialRoute: Routes.splashScreen,
          builder: (ctx, extendedNav) => ScrollConfiguration(
            behavior: RefreshScrollBehavior(),
            child: MediaQuery(
              data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
              child: Theme(
                data: lightTheme,
                child: extendedNav,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
