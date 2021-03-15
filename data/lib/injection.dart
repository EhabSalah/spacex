import 'package:dio/dio.dart';
import 'package:domain/build_config.dart';
import 'package:domain/usecase/get_past_launches_use_case.dart';
import 'package:domain/usecase/get_launch_details_use_case.dart';
import 'package:domain/usecase/get_next_launch_details_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';
import 'remote/app_service_provider.dart';

final getIt = GetIt.instance;

@module
abstract class DataModule {
  @Named('baseUrl')
  String get baseUrl => BuildConfig.of().baseUrl;

  @lazySingleton
  Dio provideAppClient(
          @Named('baseUrl') String url) =>
      initAppServiceClient(
        url,
      );

  @injectable
  GetPastLaunchesUseCase get provideGetServicesListUseCase =>
      GetPastLaunchesUseCase(getIt());
  @injectable
  GetLaunchDetailsUseCase get provideGetLaunchDetailsUseCase =>
      GetLaunchDetailsUseCase(getIt());
  @injectable
  GetNextLaunchUseCase get provideGetNextLaunchUseCase =>
      GetNextLaunchUseCase(getIt());
}

@InjectableInit(
  initializerName: r'$initData',
  preferRelativeImports: true,
  asExtension: true,
)
 configureDataDependencies() => getIt.$initData();
