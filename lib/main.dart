import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Rijks Museum',
      theme: ThemeData(
        backgroundColor: Colors.grey.shade400,
        primarySwatch: Colors.grey,
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
