import 'package:dio/dio.dart';
import 'package:domain/repository/launch_repository.dart';
import 'package:domain/result/result.dart';
import 'package:domain/entity/launch.dart';

class GetLaunchDetailsUseCase {
  final LaunchRepository _servicesRepository;

  GetLaunchDetailsUseCase(this._servicesRepository);

  Future<Result<Launch>> call(CancelToken cancelToken, String launchId) async {
    return _servicesRepository.launchDetails(cancelToken, launchId);
  }
}
