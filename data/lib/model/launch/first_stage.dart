import 'package:freezed_annotation/freezed_annotation.dart';

import 'core.dart';


part 'first_stage.freezed.dart';
part 'first_stage.g.dart';

@freezed
abstract class FirstStage with _$FirstStage {
  factory FirstStage({
    final List<Core> cores,
  }) = _FirstStage;

  factory FirstStage.fromJson(Map<String, dynamic> json) =>
      _$FirstStageFromJson(json);
}
