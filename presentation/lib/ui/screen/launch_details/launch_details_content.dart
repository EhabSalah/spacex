import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:presentation/util/common_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../res/color.dart';
import '../../../util/hooks.dart';
import '../../../util/snackbar.dart';
import '../../../util/state_layout.dart';
import '../../component/error_layout.dart';
import '../../component/item_overview.dart';
import '../../component/loading.dart';
import '../../component/network_image.dart';
import '../../component/smart_refresh_header.dart';
import 'launch_details_view_model.dart';

class LaunchDetailsContent extends HookWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final AutoDisposeChangeNotifierProvider<LaunchDetailsViewModel> viewModel;

  LaunchDetailsContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final viewModelProvider = useProvider(viewModel);

    usePostFrameCallback(() {
      viewModelProvider.fetchServiceDetails();
      return null;
    }, []);

    return ProviderListener<LaunchDetailsViewModel>(
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
      provider: viewModel,
      child: StateLayout(
        child: _buildBody(context, viewModelProvider),
        error: _buildErrorLayout(context, viewModelProvider),
        isLoading: viewModelProvider.isLoading,
        loadingIndicator:
            buildLoadingIndicator(context, 60.0, showMessage: true),
      ),
    );
  }

  _buildBody(
    BuildContext context,
    LaunchDetailsViewModel viewModelProvider,
  ) {
    if (viewModelProvider.launchDetails == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      header: SmartRefreshHeader(),
      onRefresh: () => viewModelProvider.fetchServiceDetails(),
      child: SingleChildScrollView(
        child: buildScrollContent(
          context,
          viewModelProvider,
        ),
      ),
    );
  }

  Widget _buildErrorLayout(
      BuildContext context, LaunchDetailsViewModel viewModelProvider) {
    if (viewModelProvider.uiMessage != null &&
        viewModelProvider.launchDetails == null) {
      return ErrorLayout(
          message: viewModelProvider.uiMessage.subtitle,
          onRetry: () => viewModelProvider.fetchServiceDetails());
    }
    return null;
  }

  Widget buildScrollContent(
    BuildContext context,
    LaunchDetailsViewModel viewModelProvider,
  ) {
    return Column(
      children: [
        buildHeader(
          context,
          viewModelProvider,
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              buildDetails(context, viewModelProvider),
              SizedBox(height: 16),
              buildRocketInfo(context, viewModelProvider),
              SizedBox(height: 16),
              buildWatchVideo(context, viewModelProvider.launchDetails.video),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader(
    BuildContext context,
    LaunchDetailsViewModel viewModelProvider,
  ) {
    return networkImage(viewModelProvider.launchDetails.img);
  }

  Widget buildDetails(
      BuildContext context, LaunchDetailsViewModel viewModelProvider) {
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
              Text(
                  viewModelProvider.launchDetails.details ??
                      'undefined launch details',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14, height: 1.8)),
              ItemOverview(
                  value: viewModelProvider.launchDetails.date ??
                      'undefined launch date',
                  icon: Icons.access_time),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRocketInfo(
      BuildContext context, LaunchDetailsViewModel viewModelProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text('Rocket Info',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'Rocket name: ${viewModelProvider.launchDetails.rocket.name}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14, height: 1.6)),
              Text('Type: ${viewModelProvider.launchDetails.rocket.type}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14, height: 1.6)),
              SizedBox(
                height: 16,
              ),
              Text('Payloads',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14, height: 1.8, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
            ]..addAll(viewModelProvider.launchDetails.rocket.payloads
                .map((e) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('ID: ${e.id}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14, height: 1.4)),
                          Text('Orbit: ${e.orbit}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14, height: 1.4)),
                          Text('Type: ${e.type}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14, height: 1.4)),
                          Text('Nationality: ${e.nationality}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 14, height: 1.4)),
                          Divider(),
                        ],
                      ),
                    ))
                .toList()),
          ),
        ),
      ],
    );
  }

  buildWatchVideo(BuildContext context, String video) {
    if (video == null || video.isEmpty) {
      return SizedBox();
    }
    return GestureDetector(
      onTap: () => CommonUtils.launchInBrowser(video),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Text(
              'Tap to watch video',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorBlue,
                  height: 1),
            ),
            SizedBox(width: 8,),
            Icon(
              Icons.arrow_forward_ios,
              color: colorBlue,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
