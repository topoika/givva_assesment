import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/theme.dart';
import 'src/providers/providers.dart';
import 'src/views/pages/events.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositories,
      child: MultiBlocProvider(
        providers: blocProvider(context: context),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Givva Assignment',
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: EventsPage(),
        ),
      ),
    );
  }
}
