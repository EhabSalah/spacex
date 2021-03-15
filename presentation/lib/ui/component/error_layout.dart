import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  final String _message;
  final Function _onRetry;

  ErrorLayout({String message, Function onRetry})
      : _message = message,
        _onRetry = onRetry;

  final retryShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_message),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            child: Text(
              'Retry'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: _onRetry,
            shape: retryShape,
          ),
        ],
      ),
    ));
  }
}
