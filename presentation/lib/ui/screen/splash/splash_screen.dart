import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../gen/assets.gen.dart';
import '../../../res/color.dart';
import '../../../router/router.gr.dart';
import '../../../util/hooks.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    usePostFrameCallback(() {
      Future.delayed(Duration(seconds: 3),
          () => context.navigator.replace(Routes.mainScreen));

      return null;
      //You can also return a
      // function that will be called when the widget is disposed if needed
    }, []);
    // The const [] means that until the widget is not disposed, don’t call the
    // effect.
    // You can provide an array of parameters and when one changed,
    // the effect will be called.
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: colorBlue,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.images.icLogo.path,
                  width: 150,
                ),
                SizedBox(
                  height: 20,
                ),
                SpinKitPulse(
                  color: Colors.white,
                  size: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
