import 'package:freezed_annotation/freezed_annotation.dart';

import 'fairings.dart' show Fairings;
import 'first_stage.dart';
import 'second_stage.dart';

part 'rocket.freezed.dart';

part 'rocket.g.dart';

@freezed
abstract class Rocket with _$Rocket {
  factory Rocket({
    @JsonKey(name: 'rocket_id') String rocketId,
    @JsonKey(name: 'rocket_name') String rocketName,
    @JsonKey(name: 'rocket_type') String rocketType,
    @JsonKey(name: 'second_stage') SecondStage secondStage,
  }) = _Rocket;

  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);
}
