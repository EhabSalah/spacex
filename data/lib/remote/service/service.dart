import 'package:data/model/launch/launch.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';


part 'service.g.dart';

@injectable
@RestApi()
abstract class Service {
  @factoryMethod
  factory Service(Dio dio) = _Service;

  @GET("/v3/launches/past")
  Future<List<Launch>> pastLaunches(
    @CancelRequest() CancelToken cancelToken,
      {
    @Query('start') String startDate,
    @Query('final') String endDate,
  });

  @GET("/v3/launches/{launch_id}")
  Future<Launch> launchDetails(
    @CancelRequest() CancelToken cancelToken,
    @Path('launch_id') String launchId,
  );
  @GET("/v3/launches/next")
  Future<Launch> nextLaunch(
    @CancelRequest() CancelToken cancelToken,
  );
}
