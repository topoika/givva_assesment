import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'blocs/fundraiser.bloc.dart';
import 'cubits/nav.cubit.dart';
import 'repos/fundraiser.repo.dart';

List<SingleChildWidget> blocProvider({required BuildContext context}) {
  return [
    BlocProvider(create: (_) => NavCubit()),
    BlocProvider(create: (_) => FundraiserBloc(repo: FundraiserRepo())),
  ];
}

List<SingleChildWidget> repositories = [
  RepositoryProvider(create: (_) => FundraiserRepo()),
];
