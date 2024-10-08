import 'package:data/model/patch/patch.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'links.freezed.dart';

part 'links.g.dart';

@freezed
abstract class Links with _$Links {
  factory Links({
    @JsonKey(name: 'patch') Patch patch,
    @JsonKey(name: 'mission_patch') String missionPatch,
    @JsonKey(name: 'mission_patch_small') String missionPatchSmall,
    @JsonKey(name: 'reddit_campaign') String redditCampaign,
    @JsonKey(name: 'reddit_launch') String redditLaunch,
    @JsonKey(name: 'reddit_recovery') String redditRecovery,
    @JsonKey(name: 'reddit_media') String redditMedia,
    @JsonKey(name: 'presskit') String presskit,
    @JsonKey(name: 'article_link') String articleLink,
    @JsonKey(name: 'wikipedia') String wikipedia,
    @JsonKey(name: 'video_link') String videoLink,
    @JsonKey(name: 'youtube_id') String youtubeId,
    @JsonKey(name: 'flickr_images') List<String> flickrImages,
  }) = _Links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}
