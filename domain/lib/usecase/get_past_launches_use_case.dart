import 'package:dio/dio.dart';
import 'package:domain/repository/launch_repository.dart';
import 'package:domain/result/result.dart';
import 'package:domain/entity/launch.dart';

class GetPastLaunchesUseCase {
  final LaunchRepository _servicesRepository;

  GetPastLaunchesUseCase(this._servicesRepository);

  Future<Result<List<Launch>>> call(
      CancelToken cancelToken, DateTime startDate, DateTime endDate) async {
    return _servicesRepository.pastLaunches(cancelToken, startDate, endDate);
  }
}
