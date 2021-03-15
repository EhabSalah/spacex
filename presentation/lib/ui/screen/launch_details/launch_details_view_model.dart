import 'dart:async';

import 'package:async/async.dart' hide Result;
import 'package:data/injection.dart';
import 'package:dio/dio.dart';
import 'package:domain/entity/launch.dart';
import 'package:domain/result/app_error.dart';
import 'package:domain/usecase/get_launch_details_use_case.dart';
import 'package:domain/usecase/get_next_launch_details_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/ui_message/error_message_translator.dart';
import '../../../util/ui_message/ui_message.dart';

class LaunchDetailsViewModel extends ChangeNotifier {
  final CancelToken _cancelToken;
  final GetLaunchDetailsUseCase _detailsUseCase;
  final GetNextLaunchUseCase _getNextLaunchDetailsUseCase;
  CancelableOperation _fetchingOperation;

  String serviceId;

  LaunchDetailsViewModel(
      this.serviceId, this._detailsUseCase, this._getNextLaunchDetailsUseCase)
      : _cancelToken = CancelToken();

  // observables
  Launch launchDetails;

  bool isLoading = false;
  UiMessage uiMessage;

  // operations

  void fetchServiceDetails() {
    uiMessage = null;
    if (launchDetails == null) {
      isLoading = true;
      notifyListeners();
    }

    final future = serviceId == null
        ? _getNextLaunchDetailsUseCase.call(_cancelToken)
        : _detailsUseCase.call(_cancelToken, serviceId);
    _fetchingOperation = CancelableOperation.fromFuture(future,
        onCancel: () => _cancelToken
            .cancel("disposed:(cancelled fetch service details)")).then(
        (result) =>
            result.when(success: onFetchDetailsSuccess, failure: onRequestFail),
        propagateCancel: true);
  }

  FutureOr onFetchDetailsSuccess(Launch data) {
    isLoading = false;
    launchDetails = data;
    notifyListeners();
  }

  FutureOr onRequestFail(AppError error) {
    isLoading = false;
    uiMessage = handleError(error);
    notifyListeners();
  }

  UiMessage handleError(AppError error) {
    String message;
    if (message == null) {
      message =
          translateError(unKnowsMessage: 'Failed to load info', error: error);
    }
    return UiMessage(
      subtitle: message,
      mode: MessageMode.negative,
    );
  }

  void cancelRunningOperation() {
    // cancel signing in
    if (_fetchingOperation != null && !_fetchingOperation.isCompleted) {
      _fetchingOperation.cancel();
    }
  }

  // listeners

  @override
  void dispose() {
    cancelRunningOperation();
    super.dispose();
  }
}

final launchDetailsViewModelProvider = ChangeNotifierProvider.family
    .autoDispose<LaunchDetailsViewModel, String>((ref, serviceId) =>
        LaunchDetailsViewModel(serviceId, getIt(), getIt()));
