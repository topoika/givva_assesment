import 'package:equatable/equatable.dart';

import '../../models/fundraiser.dart';

class FundraiserStates extends Equatable {
  const FundraiserStates();

  @override
  List<Object?> get props => [];
}

class FundraiserInitialState extends FundraiserStates {}

class FundraiserLoadingState extends FundraiserStates {
  final String? operation;
  const FundraiserLoadingState({this.operation});
  @override
  List<Object?> get props => [operation];
}

class FundraiserError extends FundraiserStates {
  final String message;
  const FundraiserError(this.message);
  @override
  List<Object?> get props => [message];
}

class FundraiserLoaded extends FundraiserStates {
  final FundraiserData data;
  const FundraiserLoaded(this.data);
  @override
  List<Object?> get props => [data];
}
