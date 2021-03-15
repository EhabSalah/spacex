import 'package:dio/dio.dart';
import 'package:domain/entity/launch.dart';
import 'package:domain/util/date/date_utils.dart';
import 'package:domain/repository/launch_repository.dart';
import 'package:domain/result/result.dart';
import 'package:injectable/injectable.dart';

import '../remote/service/service.dart';
import '../mapper/lanch_mapper.dart';

@Injectable(as: LaunchRepository)
class LaunchRepositoryImp implements LaunchRepository {
  final Service _servicesService;


  LaunchRepositoryImp(this._servicesService);

  @override
  Future<Result<List<Launch>>> pastLaunches(
      CancelToken cancelToken, DateTime startDate, DateTime endDate) {
    return Result.guardFuture(() async {
      final response = await _servicesService.pastLaunches(
        cancelToken,
        endDate: startDate == null ? '' : dateToServerDate(endDate),
        startDate: startDate == null ? '' : dateToServerDate(startDate),
      );
      return response.map((e) => e.toDomain()).toList();
    });
  }

  @override
  Future<Result<Launch>> launchDetails(
      CancelToken cancelToken, String launchId) {
    return Result.guardFuture(() async {
      final response =
          await _servicesService.launchDetails(cancelToken, launchId);
      return response.toDomain();
    });
  }

  @override
  Future<Result<Launch>> nextLaunch(CancelToken cancelToken) {
    return Result.guardFuture(() async {
      final response =
      await _servicesService.nextLaunch(cancelToken);
      return response.toDomain();
    });  }
}
