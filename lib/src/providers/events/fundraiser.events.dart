import 'package:equatable/equatable.dart';

class FundraiserEvents extends Equatable {
  const FundraiserEvents();

  @override
  List<Object?> get props => [];
}

class LoadFundraiserEvent extends FundraiserEvents {
  final int page;
  final String tab;
  const LoadFundraiserEvent({required this.page, required this.tab});
  @override
  List<Object?> get props => [page, tab];
}
