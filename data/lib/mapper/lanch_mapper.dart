import 'package:domain/entity/launch.dart' as domain_launch;
import 'package:domain/entity/payload/payload.dart' as domain_payload;
import 'package:domain/entity/rocket/rocket.dart' as domain_rocket;

import '../model/launch/launch.dart';

extension LaunchMapper on Launch {
  domain_launch.Launch toDomain() {
    return domain_launch.Launch(
        name: missionName,
        date: launchDateUtc,
        details: details,
        img: links.missionPatch,
        id: flightNumber.toString(),
        video: links.videoLink,
        rocket: domain_rocket.Rocket(
            name: rocket.rocketName,
            type: rocket.rocketType,
            payloads: rocket.secondStage.payloads
                .map((e) => domain_payload.Payload(
                      id: e.payloadId,
                      type: e.payloadType,
                      nationality: e.nationality,
                      orbit: e.orbit,
                    ))
                .toList()));
  }
}
