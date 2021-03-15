import 'package:freezed_annotation/freezed_annotation.dart';

part 'reuse.freezed.dart';

part 'reuse.g.dart';

@freezed
abstract class Reuse with _$Reuse {
  factory Reuse({
    bool core,
    @JsonKey(name: 'side_core1') bool sideCore1,
    @JsonKey(name: 'side_core2') bool sideCore2,
    bool fairings,
    bool capsule,
  }) = _Reuse;

  factory Reuse.fromJson(Map<String, dynamic> json) => _$ReuseFromJson(json);
}
