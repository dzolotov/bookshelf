import 'dart:io';

import 'package:bookshelf/navigation/autoroute.gr.dart';
import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final logger = Logger();

void main() {
  // setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class NavigationStateDTO {
  bool welcome;
  int? bookId;
  NavigationStateDTO(this.welcome, this.bookId);
  NavigationStateDTO.welcome()
      : welcome = true,
        bookId = null;
  NavigationStateDTO.books()
      : welcome = false,
        bookId = null;
  NavigationStateDTO.book(int id)
      : welcome = false,
        bookId = id;
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final routeObserver = RouteObserver();
    return Provider<RouteObserver>.value(
      value: routeObserver,
      child: kIsWeb || Platform.isAndroid
          ? Builder(
              builder: (context) {
                return MaterialApp.router(
                  routerDelegate: _appRouter.delegate(),
                  routeInformationParser: _appRouter.defaultRouteParser(),
                );
              },
            )
          : Builder(
              builder: (context) {
                return CupertinoApp.router(
                  routerDelegate: _appRouter.delegate(),
                  routeInformationParser: _appRouter.defaultRouteParser(),
                );
              },
            ),
    );
  }
}
