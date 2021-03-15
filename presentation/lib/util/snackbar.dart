import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../res/color.dart';
import 'ui_message/ui_message.dart';

void showFloatingSnackBar(BuildContext context,
    {String title,
    @required String subtitle,
    @required MessageMode messageMode}) {
  Flushbar(
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    margin: EdgeInsets.all(10),
    borderRadius: 6,
    backgroundGradient: messageMode == MessageMode.positive
        ? colorBgPositiveMessage
        : messageMode == MessageMode.neutral
            ? colorBgNeutralMessage
            : colorBgNegativeMessage,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    duration: Duration(seconds: 3),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: subtitle,
  )..show(context);
}
