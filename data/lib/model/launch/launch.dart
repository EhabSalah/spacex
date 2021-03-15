import 'package:freezed_annotation/freezed_annotation.dart';

import 'failure_details.dart';
import 'launch_site.dart';
import 'links.dart';
import 'reuse.dart';
import 'rocket.dart';
import 'telemetry.dart';

part 'launch.freezed.dart';

part 'launch.g.dart';

@freezed
abstract class Launch with _$Launch {
  factory Launch({
    @JsonKey(name: 'flight_number') int flightNumber,
    @JsonKey(name: 'mission_name') String missionName,
    @JsonKey(name: 'mission_id') List<String> missionId,
    @JsonKey(name: 'upcoming') bool upcoming,
    @JsonKey(name: 'launch_year') String launchYear,
    @JsonKey(name: 'launch_date_unix') int launchDateUnix,
    @JsonKey(name: 'launch_date_utc') DateTime launchDateUtc,
    @JsonKey(name: 'launch_date_local') DateTime launchDateLocal,
    @JsonKey(name: 'is_tentative') bool isTentative,
    @JsonKey(name: 'tentative_max_precision') String tentativeMaxPrecision,
    @JsonKey(name: 'tbd') bool tbd,
    @JsonKey(name: 'launch_window') int launchWindow,
    @JsonKey(name: 'rocket') Rocket rocket,
    @JsonKey(name: 'ships') List<String> ships,
    @JsonKey(name: 'telemetry') Telemetry telemetry,
    @JsonKey(name: 'reuse') Reuse reuse,
    @JsonKey(name: 'launch_site') LaunchSite launchSite,
    @JsonKey(name: 'launch_success') bool launchSuccess,
    @JsonKey(name: 'launch_failure_details')
        LaunchFailureDetails launchFailureDetails,
    @JsonKey(name: 'links') Links links,
    @JsonKey(name: 'details') String details,
    @JsonKey(name: 'static_fire_date_utc') DateTime staticFireDateUtc,
    @JsonKey(name: 'static_fire_date_unix') int staticFireDateUnix,
    @JsonKey(name: 'timeline') Map<String, int> timeline,
    @JsonKey(name: 'crew') List<dynamic> crew,
    @JsonKey(name: 'last_date_update') DateTime lastDateUpdate,
    @JsonKey(name: 'last_ll_launch_date') DateTime lastLlLaunchDate,
    @JsonKey(name: 'last_ll_update') DateTime lastLlUpdate,
    @JsonKey(name: 'last_wiki_launch_date') DateTime lastWikiLaunchDate,
    @JsonKey(name: 'last_wiki_revision') String lastWikiRevision,
    @JsonKey(name: 'last_wiki_update') DateTime lastWikiUpdate,
    @JsonKey(name: 'launch_date_source') String launchDateSource,
  }) = _Launch;

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
}
