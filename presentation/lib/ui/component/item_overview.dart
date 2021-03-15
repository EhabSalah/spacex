import 'package:flutter/material.dart';

import '../../res/color.dart';

class ItemOverview extends StatelessWidget {
  final IconData icon;

  final dynamic value;

  ItemOverview({this.icon, this.value});

  @override
  Widget build(BuildContext context) {
    return value == null
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(children: [
              Icon(icon, color: colorBlue, size: 18),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(value.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w100)),
              )
            ]),
          );
  }
}
