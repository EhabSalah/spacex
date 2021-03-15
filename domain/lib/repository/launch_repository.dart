import 'package:dio/dio.dart';
import 'package:domain/entity/launch.dart';

import '../result/result.dart';

mixin LaunchRepository {
  Future<Result<List<Launch>>> pastLaunches(
      CancelToken cancelToken, DateTime startDate, DateTime endDate);

  Future<Result<Launch>> launchDetails(
      CancelToken cancelToken, String launchId);
  Future<Result<Launch>> nextLaunch(
      CancelToken cancelToken);
}
