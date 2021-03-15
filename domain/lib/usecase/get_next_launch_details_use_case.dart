import 'package:dio/dio.dart';
import 'package:domain/repository/launch_repository.dart';
import 'package:domain/result/result.dart';
import 'package:domain/entity/launch.dart';

class GetNextLaunchUseCase {
  final LaunchRepository _servicesRepository;

  GetNextLaunchUseCase(this._servicesRepository);

  Future<Result<Launch>> call(CancelToken cancelToken) async {
    return _servicesRepository.nextLaunch(cancelToken);
  }
}
