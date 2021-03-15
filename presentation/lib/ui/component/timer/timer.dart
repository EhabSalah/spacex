import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends StateNotifier<TimerModel> {
  Duration duration;

  TimerNotifier() : super(TimerModel('00:00:00', TimeState.initial));

  final Ticker _ticker = Ticker();
  StreamSubscription<int> _tickerSubscription;

  static String _durationString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void start() {
    _startTimer();
  }

  void _startTimer() {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: duration.inSeconds).listen((duration) {
      state = TimerModel(
          _durationString(Duration(seconds: duration)), TimeState.started);
    });

    _tickerSubscription.onDone(() {
      state = TimerModel(state.timeLeft, TimeState.finished);
    });

    state = TimerModel(_durationString(duration), TimeState.started);
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

class TimerModel {
  const TimerModel(this.timeLeft, this.timeState);

  final String timeLeft;
  final TimeState timeState;
}

enum TimeState {
  initial,
  started,
  finished,
}
