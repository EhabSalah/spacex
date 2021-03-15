import 'package:freezed_annotation/freezed_annotation.dart';

import '../launch/links.dart';

part 'past_launch.freezed.dart';

part 'past_launch.g.dart';

@freezed
abstract class PastLaunch with _$PastLaunch {
  factory PastLaunch({
    Links links,
    @JsonKey(name: 'static_fire_date_utc') DateTime staticFireDateUtc,
    @JsonKey(name: 'launch_date_utc') DateTime launchDateUtc,
    int staticFireDateUnix,
    bool autoUpdate,
    String launchLibraryId,
    String details,
    int flightNumber,
    String name,
    String id,
  }) = _PastLaunch;

  factory PastLaunch.fromJson(Map<String, dynamic> json) =>
      _$PastLaunchFromJson(json);
}
