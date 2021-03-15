import 'package:async/async.dart' hide Result;
import 'package:data/injection.dart';
import 'package:dio/dio.dart';
import 'package:domain/entity/launch.dart';
import 'package:domain/result/app_error.dart';
import 'package:domain/usecase/get_past_launches_use_case.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/ui_message/error_message_translator.dart';
import '../../../util/ui_message/ui_message.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPastLaunchesUseCase _getLaunchesUseCase;
  final CancelToken _cancelToken;
  CancelableOperation _fetchingOperation;
  DateTime end;
  DateTime startDate;

  HomeViewModel(
    this._getLaunchesUseCase,
  ) : _cancelToken = CancelToken();

  // observables

  List<Launch> launches;

  bool isLoading = false;
  UiMessage uiMessage;

  // operations
  Future<void> fetchHome() async {
    uiMessage = null;
    isLoading = true;
    if (launches == null) {
      notifyListeners();
    }

    final futureServices = _getLaunchesUseCase.call(
      _cancelToken,
      startDate,
      end,
    );

    _fetchingOperation = CancelableOperation.fromFuture(futureServices,
            onCancel: () => _cancelToken
                .cancel("cancelled( when changeNotifier dispose is disposed )"))
        .then((result) {
      result.when(success: onFetchSuccess, failure: onFetchFailure);
    }, propagateCancel: true);
  }

  // listeners

  void onFetchFailure(AppError error) {
    isLoading = false;

    uiMessage = handleError(error);

    notifyListeners();
  }

  UiMessage handleError(AppError error) {
    String message;
    // the codes the i need to custom its meaning to user
    // if (error.type == AppErrorType.notFound) {
    //   message = LocaleKeys.msg_wrong_credentials;
    // }
    if (message == null) {
      message =
          translateError(unKnowsMessage: 'Failed to get info', error: error);
    }
    return UiMessage(
      subtitle: message,
      mode: MessageMode.negative,
    );
  }

  @override
  void dispose() {
    cancelRunningOperation();
    super.dispose();
  }

  void cancelRunningOperation() {
    // if user is signing up and operation not completed cancel it
    if (_fetchingOperation != null && !_fetchingOperation.isCompleted) {
      _fetchingOperation.cancel();
    }
  }

  void onFetchSuccess(List<Launch> launches) {
    uiMessage = null;
    isLoading = false;
    this.launches = launches;
    notifyListeners();
  }

  void onDateRangeSelected(List<DateTime> pickedRange) {
    if (pickedRange != null && pickedRange.length == 2) {
      startDate = pickedRange[0];
      end = pickedRange[1];
      launches = null;
      fetchHome();
    }
  }

  clearDates() {
    startDate = null;
    end = null;
    launches = null;
    fetchHome();
  }
}

final homeViewModelProvider =
    ChangeNotifierProvider.autoDispose<HomeViewModel>((ref) => getIt());
