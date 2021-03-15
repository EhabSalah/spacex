import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presentation/util/date/date_utils.dart';

import '../../gen/assets.gen.dart';

class ItemLaunch extends StatelessWidget {
  final String title;

  final String desc;

  final DateTime date;
  final String img;

  final Function onPressed;

  ItemLaunch({this.title, this.desc, this.date, this.img, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: img == null ? null : BoxFit.cover,
                    image: img == null
                        ? Assets.images.imgPlaceholer
                        : CachedNetworkImageProvider(img))),
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  Color(0xff32425c).withOpacity(.7),
                  Color(0xff32425c).withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.center)),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                date == null
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff32425c).withOpacity(.5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  dateToAppDate(date),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          height: 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title ?? '',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        desc ?? '',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.white, fontSize: 13, height: 1),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
