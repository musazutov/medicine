import 'package:flutter/material.dart';
import 'package:testtask/screens/preparation_detail_screen.dart';
import 'package:testtask/screens/preparations_screen.dart';

import 'variables.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case Screens.preparations:
        return MaterialPageRoute(
            settings: settings, builder: (_) => PreparationsScreen());

      case Screens.preparationDetail:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PreparationDetailScreen(
                preparationId: (settings.arguments ?? 0) as int));
    }
  }
}
