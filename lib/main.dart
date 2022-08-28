import 'dart:io';

import 'package:bookshelf/navigation/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/delegate.dart';
import 'navigation/parser.dart';

final logger = Logger();

void main() {
  runApp(const MyApp());
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeObserver = RouteObserver();
    return Provider<RouteObserver>.value(
      value: routeObserver,
      child: kIsWeb || Platform.isAndroid
          ? Builder(
              builder: (context) {
                return MaterialApp.router(
                  routerDelegate: BookshelfRouterDelegate(),
                  routeInformationParser: BooksShelfRouteInformationParser(),
                  routeInformationProvider: DebugRouteInformationProvider(),
                  theme: Theme.of(context).copyWith(
                      pageTransitionsTheme:
                          const PageTransitionsTheme(builders: {
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
                  })),
                );
              },
            )
          : Builder(
              builder: (context) {
                return CupertinoApp.router(
                  routerDelegate: BookshelfRouterDelegate(),
                  routeInformationParser: BooksShelfRouteInformationParser(),
                  routeInformationProvider: DebugRouteInformationProvider(),
                );
              },
            ),
    );
  }
}
