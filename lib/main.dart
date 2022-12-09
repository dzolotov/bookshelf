import 'dart:io';

import 'package:bookshelf/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/controller.dart';
import 'navigation/models.dart';
import 'navigation/routes.dart';
import 'screens/books.dart';
import 'screens/details.dart';

class NavigationState {
  bool isWelcome = false;
  int? bookId;

  NavigationState(this.isWelcome, this.bookId);

  @override
  String toString() => "Welcome: $isWelcome, book: $bookId";
}

class BookshelfRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
  NavigationState state = NavigationState(true, null);

  bool get isWelcome => state.isWelcome;

  bool get isBooksList => !state.isWelcome && state.bookId == null;

  bool get isBookDetails => !state.isWelcome && state.bookId != null;

  void gotoBooks() {
    state
      ..isWelcome = false
      ..bookId = null;
    notifyListeners();
  }

  void gotoBook(int id) {
    state
      ..isWelcome = false
      ..bookId = id;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      key: navigatorKey,
      pages: [
        if (state.isWelcome)
          const MaterialPage(
            child: WelcomeScreen(),
          ),
        if (!state.isWelcome)
          const MaterialPage(
            child: BooksScreen(),
          ),
        if (state.bookId != null)
          MaterialPage(
            child: DetailsScreen(
              BookId(state.bookId!),
            ),
          )
      ],
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isWelcome, state.bookId);
  }

  @override
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.bookId = configuration.bookId;
    state.isWelcome = configuration.welcome;
    return Future.value();
  }
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

  @override
  String toString() {
    return "Welcome=$welcome, bookId=$bookId";
  }
}

class Paths {
  static const welcome = '';
  static const books = 'books';
  static const book = 'book';
}

class AppState with ChangeNotifier {
  bool isWelcome = true;
  int? bookId;

  set welcome(bool v) {
    isWelcome = v;
    notifyListeners();
  }

  set book(int? v) {
    bookId = v;
    notifyListeners();
  }

  void gotoWelcome() {
    print('Go to welcome');
    welcome = true;
    bookId = null;
  }

  void gotoBooksList() {
    print('Go to books list');
    welcome = false;
    bookId = null;
  }

  void gotoBookList(int? id) {
    print('Go to book $id');
    welcome = false;
    bookId = id;
  }
}

void main() {
  runApp(ChangeNotifierProvider.value(
    value: AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: kIsWeb || Platform.isAndroid
          ? MaterialApp.router(
              routerDelegate: BookshelfRouterDelegate(),
            )
          : CupertinoApp.router(
              routerDelegate: BookshelfRouterDelegate(),
            ),
    );
  }
}
