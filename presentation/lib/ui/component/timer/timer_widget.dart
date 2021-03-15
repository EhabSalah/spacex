import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/hooks.dart';
import 'timer.dart';

final timerProvider = StateNotifierProvider<TimerNotifier>(
  (ref) => TimerNotifier(),
);

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider.state).timeLeft;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

class TimerTextWidget extends HookWidget {
  final DateTime date;

  TimerTextWidget(this.date);

  @override
  Widget build(BuildContext context) {
    usePostFrameCallback(() {
      context.read(timerProvider).duration = _countdownDuration(date);
      context.read(timerProvider).start();
      return null;
    }, []);
    final timeLeft = useProvider(timeLeftProvider);
    return Column(
      children: [
        Text(
          'Next launch within',
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 20),
        ),
        Text(
          timeLeft,
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}

Duration _countdownDuration(DateTime launchDate) {
  final currentDate = DateTime.now();
  final difference = currentDate.difference(launchDate);
  return difference;
}
