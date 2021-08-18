import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/pages/details_page.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/pages/home_page.dart';
import 'package:rijksmuseumapp/app/router/app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.DETAILS_PAGE:
        final args = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => DetailsPage(
            objectNumber: args['objectNumber'],
          ),
        );
      default:
        return null;
    }
  }
}
