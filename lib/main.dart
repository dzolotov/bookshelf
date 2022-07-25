import 'dart:io';

import 'package:bookshelf/screens/unknown.dart';
import 'package:bookshelf/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/controller.dart';
import 'navigation/models.dart';
import 'navigation/routes.dart';
import 'screens/books.dart';
import 'screens/details.dart';
import 'tracing/navigator_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    final routeObserver = RouteObserver();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: Provider<RouteObserver>.value(
        value: routeObserver,
        child: Platform.isAndroid
            ? MaterialApp(
                initialRoute: Routes.welcome,
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case Routes.welcome:
                      return MaterialPageRoute(
                          builder: (_) => const WelcomeScreen());
                    case Routes.books:
                      return MaterialPageRoute(
                          builder: (_) => const BooksScreen());
                    case Routes.details:
                      return MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(settings.arguments as BookId));
                    default:
                      return MaterialPageRoute(
                          builder: (_) => UnknownPage(settings.name));
                  }
                },
                navigatorKey: navigationController.key,
              )
            : CupertinoApp(
                navigatorKey: navigationController.key,
                navigatorObservers: [
                  ShelfNavigatorObserver(),
                  routeObserver,
                ],
                initialRoute: Routes.welcome,
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case Routes.welcome:
                      return MaterialPageRoute(
                          builder: (_) => const WelcomeScreen());
                    case Routes.books:
                      return MaterialPageRoute(
                          builder: (_) => const BooksScreen());
                    case Routes.details:
                      return MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(settings.arguments as BookId));
                    default:
                      return MaterialPageRoute(
                          builder: (_) => UnknownPage(settings.name));
                  }
                },
              ),
      ),
    );
  }
}
