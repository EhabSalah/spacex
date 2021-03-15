import 'package:domain/entity/rocket/rocket.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch.freezed.dart';

@freezed
abstract class Launch with _$Launch {
  factory Launch({
    String name,
    DateTime date,
    String img,
    String details,
    String id,
    Rocket rocket,
    String video,
  }) = _Launch;
}
