import 'package:domain/entity/launch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../res/color.dart';
import '../../../util/hooks.dart';
import '../../../util/snackbar.dart';
import '../../../util/state_layout.dart';
import '../../../util/ui_message/ui_message.dart';
import '../../component/error_layout.dart';
import '../../component/item_overview.dart';
import '../../component/loading.dart';
import '../../component/network_image.dart';
import '../../component/smart_refresh_header.dart';
import '../../component/timer/timer_widget.dart';
import 'next_launch_view_model.dart';

class NextLaunchContent extends HookWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final isLoading = useProvider(
        nextLaunchViewModelProvider.select((value) => value.isLoading));
    final uiMessage = useProvider(
        nextLaunchViewModelProvider.select((value) => value.uiMessage));
    final launchDetails = useProvider(
        nextLaunchViewModelProvider.select((value) => value.launchDetails));
    usePostFrameCallback(() {
      context.read(nextLaunchViewModelProvider).fetchNextLaunch();
      return null;
    }, []);

    return ProviderListener<NextLaunchViewModel>(
      onChange: (context, value) {
        if (_refreshController.isRefresh) {
          // handle on refresh finish

          if (value.uiMessage != null) {
            /// error
            final snackMessage = value.uiMessage;
            showFloatingSnackBar(
              context,
              subtitle: snackMessage.subtitle,
              messageMode: snackMessage.mode,
            );
            value.uiMessage = null;

            _refreshController.refreshFailed();
          } else {
            /// no error

            _refreshController.refreshCompleted();
          }
          return;
        }
      },
      provider: nextLaunchViewModelProvider,
      child: StateLayout(
        child: _buildBody(context, launchDetails),
        error: _buildErrorLayout(context, uiMessage, launchDetails),
        isLoading: isLoading,
        loadingIndicator:
            buildLoadingIndicator(context, 60.0, showMessage: true),
      ),
    );
  }

  _buildBody(BuildContext context, Launch launchDetails) {
    if (launchDetails == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      header: SmartRefreshHeader(),
      onRefresh: () =>
          context.read(nextLaunchViewModelProvider).fetchNextLaunch(),
      child: SingleChildScrollView(
        child: buildScrollContent(
          context,
          launchDetails,
        ),
      ),
    );
  }

  Widget _buildErrorLayout(
    BuildContext context,
    UiMessage uiMessage,
    Launch launchDetails,
  ) {
    if (uiMessage != null && launchDetails == null) {
      return ErrorLayout(
          message: uiMessage.subtitle,
          onRetry: () =>
              context.read(nextLaunchViewModelProvider).fetchNextLaunch());
    }
    return null;
  }

  Widget buildScrollContent(
    BuildContext context,
    Launch launchDetails,
  ) {
    return Column(
      children: [
        buildHeader(context, launchDetails.img),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              TimerTextWidget(launchDetails.date),
              buildOverView(context, launchDetails),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context, String img) {
    return networkImage(img, fit: BoxFit.cover);
  }

  buildOverView(BuildContext context, Launch launchDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text('Details',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorBlueBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(launchDetails.details ?? 'undefined launch details',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14, height: 1.8)),
              ItemOverview(
                  value: launchDetails.date ?? 'undefined launch date',
                  icon: Icons.access_time),
            ],
          ),
        ),
      ],
    );
  }
}
