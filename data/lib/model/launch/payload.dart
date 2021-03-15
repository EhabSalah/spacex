import 'package:freezed_annotation/freezed_annotation.dart';

import 'orbit_params.dart';


part 'payload.freezed.dart';
part 'payload.g.dart';

@freezed
abstract class Payload with _$Payload {
  factory Payload({
    @JsonKey(name: 'payload_id') String payloadId,
    @JsonKey(name: 'reused') bool reused,
    @JsonKey(name: 'customers') List<String> customers,
    @JsonKey(name: 'nationality') String nationality,
    @JsonKey(name: 'manufacturer') String manufacturer,
    @JsonKey(name: 'payload_type') String payloadType,
    @JsonKey(name: 'payload_mass_kg') double payloadMassKg,
    @JsonKey(name: 'payload_mass_lbs') double payloadMassLbs,
    @JsonKey(name: 'orbit') String orbit,
    @JsonKey(name: 'orbit_params') OrbitParams orbitParams,
  }) = _Payload;

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
}

