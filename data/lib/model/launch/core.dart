import 'package:freezed_annotation/freezed_annotation.dart';
part 'core.freezed.dart';

part 'core.g.dart';

@freezed
abstract class Core with _$Core {
  factory Core({
    @JsonKey(name: 'core_serial') String coreSerial,
    int flight,
    int block,
    bool gridfins,
    bool legs,
    bool reused,
    @JsonKey(name: 'land_success') bool landSuccess,
    @JsonKey(name: 'landing_intent') bool landingIntent,
    @JsonKey(name: 'landing_type') String landingType,
    @JsonKey(name: 'landing_vehicle') String landingVehicle,
  }) = _Core;

  factory Core.fromJson(Map<String, dynamic> json) => _$CoreFromJson(json);
}
