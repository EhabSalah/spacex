import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_details.freezed.dart';

part 'failure_details.g.dart';

@freezed
abstract class LaunchFailureDetails with _$LaunchFailureDetails {
  factory LaunchFailureDetails({
    int time,
    int altitude,
    String reason,
  }) = _LaunchFailureDetails;

  factory LaunchFailureDetails.fromJson(Map<String, dynamic> json) =>
      _$LaunchFailureDetailsFromJson(json);
}
