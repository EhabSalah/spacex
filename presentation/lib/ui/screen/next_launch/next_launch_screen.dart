import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/snackbar.dart';
import 'next_launch_content.dart';
import 'next_launch_view_model.dart';

class NextLaunchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final launchDetails = useProvider(
        nextLaunchViewModelProvider.select((value) => value.launchDetails));

    return Scaffold(
      appBar: AppBar(
        title: Text(launchDetails == null ? '' : launchDetails.name),
        actions: [],
      ),
      body: ProviderListener<NextLaunchViewModel>(
          provider: nextLaunchViewModelProvider,
          onChange: (context, value) {
            if (value.uiMessage != null && value.launchDetails != null) {
              /// show snack message
              final snackMessage = value.uiMessage;

              showFloatingSnackBar(
                context,
                subtitle: snackMessage.subtitle,
                messageMode: snackMessage.mode,
              );
              value.uiMessage = null;
            }
          },
          child: NextLaunchContent()),
    );
  }
}
