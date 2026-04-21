// FundraiserBloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/fundraiser.events.dart';
import '../repos/fundraiser.repo.dart';
import '../states/fundraiser.states.dart';

class FundraiserBloc extends Bloc<FundraiserEvents, FundraiserStates> {
  final FundraiserRepo repo;

  FundraiserBloc({required this.repo}) : super(FundraiserInitialState()) {
    on<LoadFundraiserEvent>((event, emit) async {
      emit(const FundraiserLoadingState(operation: 'load_fundraisers'));
      try {
        final data = await repo.getFundraisers(
          tab: event.tab,
          page: event.page,
        );
        emit(FundraiserLoaded(data));
      } catch (e) {
        emit(FundraiserError(e.toString()));
      }
    });
  }
}
