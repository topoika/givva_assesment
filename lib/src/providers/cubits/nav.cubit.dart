import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<NavCubitStat> {
  NavCubit() : super(NavCubitStat.initial());

  void changeTab(String tab) {
    final restoredPage = state.tabPages[tab] ?? 0;
    emit(state.copyWith(currentTab: tab, currentPage: restoredPage));
  }

  void changePage(int page) {
    final nextTabPages = Map<String, int>.from(state.tabPages)
      ..[state.currentTab] = page;
    emit(state.copyWith(currentPage: page, tabPages: nextTabPages));
  }
}

class NavCubitStat {
  String currentTab;
  int? currentPage;
  Map<String, int> tabPages;

  NavCubitStat({
    required this.currentTab,
    this.currentPage,
    required this.tabPages,
  });

  factory NavCubitStat.initial() => NavCubitStat(
    currentTab: 'community',
    currentPage: 0,
    tabPages: {'community': 0, 'subgroup': 0, 'archived': 0},
  );

  NavCubitStat copyWith({
    String? currentTab,
    int? currentPage,
    Map<String, int>? tabPages,
  }) {
    return NavCubitStat(
      currentTab: currentTab ?? this.currentTab,
      currentPage: currentPage ?? this.currentPage,
      tabPages: tabPages ?? this.tabPages,
    );
  }
}
