import 'dart:io';

import 'package:bookshelf/screens/books.dart';
import 'package:bookshelf/screens/details.dart';
import 'package:bookshelf/screens/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/models.dart';
import 'navigation/paths.dart';

final logger = Logger();

void main() {
  // setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

final goRouter = GoRouter(routes: [
  GoRoute(
      name: Paths.welcome,
      path: '/',
      builder: (context, state) => const WelcomeScreen()),
  GoRoute(
      name: Paths.books,
      path: '/books',
      builder: (context, state) => const BooksScreen()),
  GoRoute(
    name: Paths.book,
    path: '/book/:id',
    builder: (context, state) => DetailsScreen(
      BookId(
        int.parse(state.params["id"]!),
      ),
    ),
  ),
]);

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
                  routerDelegate: goRouter.routerDelegate,
                  routeInformationParser: goRouter.routeInformationParser,
                );
              },
            )
          : Builder(
              builder: (context) {
                return CupertinoApp.router(
                  routerDelegate: goRouter.routerDelegate,
                  routeInformationParser: goRouter.routeInformationParser,
                );
              },
            ),
    );
  }
}
