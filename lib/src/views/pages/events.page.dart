import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_assesment/src/providers/blocs/fundraiser.bloc.dart';
import 'package:givva_assesment/src/views/components/loading.widget.dart';

import '../../providers/cubits/nav.cubit.dart';
import '../../providers/events/fundraiser.events.dart';
import '../../providers/states/fundraiser.states.dart';
import '../components/error.empty.widget.dart';
import '../components/event.item.widget.dart';
import '../components/pagination.widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const List<String> _tabs = ['community', 'subgroup', 'archived'];

  @override
  void initState() {
    super.initState();
    final navState = context.read<NavCubit>().state;
    final initialIndex = _tabs.indexOf(navState.currentTab).clamp(0, 2);

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FundraiserBloc>().add(
        LoadFundraiserEvent(
          tab: navState.currentTab,
          page: navState.currentPage ?? 0,
        ),
      );
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      return;
    }

    final navCubit = context.read<NavCubit>();
    final targetTab = _tabs[_tabController.index];

    if (navCubit.state.currentTab == targetTab) {
      return;
    }

    navCubit.changeTab(targetTab);
    final restoredPage = navCubit.state.currentPage ?? 0;

    context.read<FundraiserBloc>().add(
      LoadFundraiserEvent(tab: targetTab, page: restoredPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navCubit = context.watch<NavCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Fund Collection Events"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            // Handle back navigation, for now no inital route, so just print a message
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
            size: 20,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.black.withValues(alpha: 0.1),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 169, 197, 147),
                Color.fromARGB(255, 248, 216, 146),
                Color.fromARGB(255, 246, 185, 169),
              ],
            ),
          ),
          labelColor: Colors.black,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(text: 'Community Events'),
            Tab(text: 'Subgroup Events'),
            Tab(text: 'Archived Events'),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0.8, 0.98],
            colors: [
              Color.fromARGB(255, 188, 206, 175),
              Color.fromARGB(255, 248, 216, 146),
              Color.fromARGB(255, 246, 185, 169),
            ],
          ),
        ),
        child: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFundraiserContent(context, navCubit),
              _buildFundraiserContent(context, navCubit),
              _buildFundraiserContent(context, navCubit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFundraiserContent(BuildContext context, NavCubit navCubit) {
    return BlocBuilder<FundraiserBloc, FundraiserStates>(
      builder: (context, state) {
        if (state is FundraiserLoadingState) {
          return LoadingTilesWidget(
            count: 10,
            radius: 8,
            height: 80,
            padding: 15,
          );
        }

        if (state is FundraiserError) {
          return ErrorNoDataWidget(
            type: ErrorType.error,
            message: state.message.replaceFirst('Exception: ', ''),
            onRetry: () {
              context.read<FundraiserBloc>().add(
                LoadFundraiserEvent(
                  tab: navCubit.state.currentTab,
                  page: navCubit.state.currentPage ?? 0,
                ),
              );
            },
          );
        }

        if (state is FundraiserLoaded) {
          if (state.data.items.isEmpty) {
            return ErrorNoDataWidget(
              type: ErrorType.empty,
              message: 'No fundraisers available for this tab.',
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<FundraiserBloc>().add(
                      LoadFundraiserEvent(
                        tab: navCubit.state.currentTab,
                        page: navCubit.state.currentPage ?? 0,
                      ),
                    );
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 13),
                    itemCount: state.data.items.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    itemBuilder: (context, index) {
                      return EventItemWidget(
                        fundraiser: state.data.items[index],
                      );
                    },
                  ),
                ),
              ),
              PaginationWidget(
                pagination: state.data.pagination,
                onPageChanged: (page) {
                  if (page < 0 || page >= state.data.pagination.totalPages) {
                    return;
                  }
                  navCubit.changePage(page);
                  context.read<FundraiserBloc>().add(
                    LoadFundraiserEvent(
                      tab: navCubit.state.currentTab,
                      page: page,
                    ),
                  );
                },
              ),
            ],
          );
        }

        return const LoadingTilesWidget(
          count: 10,
          radius: 8,
          height: 80,
          padding: 15,
        );
      },
    );
  }
}
