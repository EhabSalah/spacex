import 'package:domain/entity/payload/payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rocket.freezed.dart';

@freezed
abstract class Rocket with _$Rocket {
  factory Rocket({
    String name,
    String type,
    List<Payload> payloads,
  }) = _Rocket;
}
