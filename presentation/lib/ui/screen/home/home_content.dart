import 'package:auto_route/auto_route.dart';
import 'package:domain/entity/launch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:presentation/ui/component/empty_services_widget.dart';
import 'package:presentation/util/date/date_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../router/router.gr.dart';
import '../../../util/hooks.dart';
import '../../../util/snackbar.dart';
import '../../../util/state_layout.dart';
import '../../component/error_layout.dart';
import '../../component/item_launch.dart';
import '../../component/loading.dart';
import '../../component/smart_refresh_header.dart';
import 'home_view_model.dart';

class HomeContent extends HookWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModelProvider);
    usePostFrameCallback(() {
      viewModel.fetchHome();
      return null;
    }, []);

    return ProviderListener<HomeViewModel>(
      provider: homeViewModelProvider,
      onChange: (context, value) {
        if (_refreshController.isRefresh) {
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
        }
      },
      child: StateLayout(
        child: _buildBody(context, viewModel),
        error: _buildErrorLayout(context, viewModel),
        isLoading: viewModel.isLoading,
        loadingIndicator:
            buildLoadingIndicator(context, 46.0, showMessage: true),
      ),
    );
  }

  _buildBody(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    if (viewModel.launches == null) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      physics: BouncingScrollPhysics(),
      enablePullDown: viewModel.launches != null,
      child: buildScrollableContent(context, viewModel),
      header: SmartRefreshHeader(),
      onRefresh: () => onRefresh(viewModel),
    );
  }

  Widget buildScrollableContent(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFiltersIndicator(context, viewModel.startDate, viewModel.end),
          SizedBox(height: 16),
          buildRecentOffers(context, viewModel.launches),
          SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget buildRecentOffers(BuildContext context, List<Launch> launches) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Past launches',
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16, height: 1, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 9,
          ),
          launches.isEmpty
              ? EmptyServicesListWidget()
              : GridView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (60 / 80),
                  ),
                  itemBuilder: (c, i) => ItemLaunch(
                      title: launches[i].name,
                      desc: launches[i].details,
                      date: launches[i].date,
                      img: launches[i].img,
                      onPressed: () => context.navigator.push(
                          Routes.launchDetailsScreen,
                          arguments: LaunchDetailsScreenArguments(
                              serviceId: launches[i].id))),
                  itemCount: launches.length,
                ),
        ],
      ),
    );
  }

  Widget _buildErrorLayout(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.uiMessage != null) {
      return ErrorLayout(
          message: viewModel.uiMessage.subtitle,
          onRetry: () => viewModel.fetchHome());
    }
    return null;
  }

  void onRefresh(HomeViewModel viewModel) async {
    viewModel.fetchHome();
  }

  Widget buildFiltersIndicator(
      BuildContext context, DateTime startDate, DateTime end) {
    if (startDate != null && end != null) {
      return GestureDetector(
        onTap: () {
          context.read(homeViewModelProvider).clearDates();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Date rang: ${dateToAppDate(startDate)} : ${dateToAppDate(end)}'),
              Icon(
                Icons.clear,
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
