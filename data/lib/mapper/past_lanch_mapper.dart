import 'package:domain/entity/launch.dart' as domain_launch;

import '../model/past_launch/past_launch.dart';

extension LaunchMapper on PastLaunch {
  domain_launch.Launch toDomain() {
    return domain_launch.Launch(
      name: name,
      date: launchDateUtc,
      details: details,
      img: links.patch.small,
      id: id,
    );
  }
}
