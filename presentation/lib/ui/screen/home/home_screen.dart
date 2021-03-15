import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:presentation/res/icons.dart';

import 'home_content.dart';
import 'home_view_model.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to SpaceX',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(AppIcons.icFilter),
            onPressed: () async => DateRagePicker.showDatePicker(
                    context: context,
                    initialFirstDate:
                        context.read(homeViewModelProvider).startDate ??
                            DateTime.now().subtract(Duration(days: 7)),
                    initialLastDate: context.read(homeViewModelProvider).end ??
                        (DateTime.now()).subtract(Duration(days: 2)),
                    firstDate: DateTime(2006),
                    lastDate: DateTime.now())
                .then((value) => context
                    .read(homeViewModelProvider)
                    .onDateRangeSelected(value)),
          )
        ],
      ),
      body: HomeContent(),
    );
  }
}
