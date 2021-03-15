import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      refreshingIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPulse(
            color: Theme.of(context).accentColor,
            size: 45,
          ),
          SizedBox(
            width: 8,
          ),
          Text('Refreshing...'),
        ],
      ),
      releaseText: 'Release to refresh',
      // Release to refresh
      completeText: 'Refresh completed',
      //Refresh completed
      failedText: 'Refresh Failed',
      //Refresh failed
      refreshingText: '',
      //Refreshing…
      idleText: 'Pull down refresh', //Pull down Refresh
    );
  }
}
