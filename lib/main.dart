import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/core/util/connectivity/connectivity_cubit.dart';
import 'package:rijksmuseumapp/app/injection/injection.dart';
import 'package:rijksmuseumapp/app/router/app_router.dart';

void main() {
  configureInjection(Env.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectivityCubit>(
      create: (context) => getIt<ConnectivityCubit>(),
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.grey.shade400,
          primarySwatch: Colors.grey,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
