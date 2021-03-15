import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/snackbar.dart';
import 'launch_details_content.dart';
import 'launch_details_view_model.dart';

class LaunchDetailsScreen extends HookWidget {
  final String serviceId;

  LaunchDetailsScreen(this.serviceId);

  @override
  Widget build(BuildContext context) {
    final viewModel = launchDetailsViewModelProvider(serviceId);
    final viewModelProvider = useProvider(viewModel);

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModelProvider.launchDetails == null
            ? ''
            : viewModelProvider.launchDetails.name),
        actions: [],
      ),
      body: ProviderListener<LaunchDetailsViewModel>(
          provider: viewModel,
          onChange: (context, value) {
            if (value.uiMessage != null && value.launchDetails != null) {
              final snackMessage = value.uiMessage;
              showFloatingSnackBar(
                context,
                subtitle: snackMessage.subtitle,
                messageMode: snackMessage.mode,
              );
              value.uiMessage = null;
            }
          },
          child: LaunchDetailsContent(viewModel)),
    );
  }
}
