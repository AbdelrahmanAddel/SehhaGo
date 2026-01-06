import 'package:flutter/material.dart';
import 'package:sehhago/core/routes/routes_strings.dart';
import 'package:sehhago/features/home/presentation/page/home_page.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings route) {
    switch (route.name) {
      case RoutesString.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case RoutesString.login:
    }
    return null;
  }
}
