import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget buildLoadingIndicator(BuildContext context, double size,
    {String message, bool showMessage, Color color}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        child: SpinKitPulse(
          color: color ?? Theme.of(context).accentColor,
          size: size,
        ),
        width: size,
      ),
      SizedBox(height: 4),
      showMessage == true
          ? Text(
              message != null ? message : 'Loading...',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            )
          : SizedBox(),
    ],
  );
}
