import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:presentation/res/color.dart';

import '../../gen/assets.gen.dart';

Widget networkImage(String url, {BoxFit fit}) {
  final placeholder = Assets.images.imgPlaceholer.image(fit: fit);

  if (url == null) {
    return placeholder;
  } else {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          SpinKitPulse(
        color: appColor,
        size: 50,
      ),
      errorWidget: (
        context,
        url,
        dynamic error,
      ) =>
          placeholder,
    );
  }
}
