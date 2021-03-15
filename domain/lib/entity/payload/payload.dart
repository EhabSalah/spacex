import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload.freezed.dart';

@freezed
abstract class Payload with _$Payload {
  factory Payload({
    String id,
    String orbit,
    String type,
    String nationality,
  }) = _Payload;
}
