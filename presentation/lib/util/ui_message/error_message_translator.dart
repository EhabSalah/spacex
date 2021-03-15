import 'package:domain/result/app_error.dart';

String translateError({String unKnowsMessage, AppError error}) {
  switch (error.type) {
    case AppErrorType.unauthorized:
      return 'Unauthorized';
    case AppErrorType.notFound:
      return 'There is no data';
    case AppErrorType.network:
      return 'No network connection';
    case AppErrorType.badRequest:
      return 'The operation could not be completed';
    case AppErrorType.cancel:
      return 'Operation canceled';
    case AppErrorType.timeout:
      return 'Connection timeout';
    case AppErrorType.server:
      return 'Connection timeout';
    case AppErrorType.unProcessableEntity:
      return 'Unhandled entries';
    default:
      return unKnowsMessage;
  }
}
