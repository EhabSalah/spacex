import 'package:flutter/material.dart';

class StateLayout extends StatelessWidget {
  final bool _isLoading;
  final Widget _child;
  final Widget _error;
  final Widget _loadingIndicator;

  StateLayout(
      {bool isLoading, Widget error, Widget child, Widget loadingIndicator})
      : _isLoading = isLoading,
        _error = error,
        _child = child,
        _loadingIndicator = loadingIndicator;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _error;
    }
    if (!_isLoading) {
      return _child;
    }
    return Stack(alignment: Alignment.center, children: <Widget>[
      _child,
      _loadingIndicator,
    ]);
  }
}
