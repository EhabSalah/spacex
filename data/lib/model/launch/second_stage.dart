import 'package:freezed_annotation/freezed_annotation.dart';

import 'payload.dart';

part 'second_stage.freezed.dart';
part 'second_stage.g.dart';

@freezed
abstract class SecondStage with _$SecondStage {
  factory SecondStage({
    final int block,
    final List<Payload> payloads,
  }) = _SecondStage;

  factory SecondStage.fromJson(Map<String, dynamic> json) =>
      _$SecondStageFromJson(json);
}
