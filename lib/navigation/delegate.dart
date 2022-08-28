import 'package:bookshelf/navigation/state.dart';
import 'package:bookshelf/navigation/transition.dart';
import 'package:bookshelf/screens/books.dart';
import 'package:bookshelf/screens/details.dart';
import 'package:bookshelf/screens/welcome.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'models.dart';

//Example of stacked router delegate (for simulating Navigator 1.0 behavior)
class StackedRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final List<Page> _pages = [];

  push(Page _page) {
    _pages.add(_page);
    notifyListeners();
  }

  pop() {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
      notifyListeners();
    }
  }

  replace(Page _page) {
    if (_pages.isEmpty) {
      _pages.add(_page);
    } else {
      _pages[_pages.length - 1] = _page;
    }
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages,
    );
  }

  @override
  get currentConfiguration => super.currentConfiguration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey();

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value();
  }
}

class CustomAnimationPage<T> extends MaterialPage<T> {
  const CustomAnimationPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
  }) : super(
          child: child,
          key: key,
          name: name,
          arguments: arguments,
        );

  @override
  Route<T> createRoute(BuildContext context) => PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        reverseTransitionDuration: const Duration(seconds: 2),
        settings: this,
        pageBuilder: (context, animation, secondAnimation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionsBuilder: (context, animation, secondAnimation, child) =>
            FractionalTranslation(
          translation: Offset(1 - animation.value, 1 - animation.value),
          child: child,
        ),
      );
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

  TransitionDelegate delegate = BookshelfTransitionDelegate();

  @override
  Widget build(BuildContext context) => Navigator(
        onPopPage: (route, result) => route.didPop(result),
        transitionDelegate: delegate,
        key: navigatorKey,
        pages: [
          if (state.isWelcome)
            const CustomAnimationPage(
              child: WelcomeScreen(),
            ),
          if (!state.isWelcome)
            const CustomAnimationPage(
              child: BooksScreen(),
            ),
          if (state.bookId != null)
            CustomAnimationPage(
              child: DetailsScreen(
                BookId(state.bookId!),
              ),
            ),
        ],
      );

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isWelcome, state.bookId);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.bookId = configuration.bookId;
    state.isWelcome = configuration.welcome;
    return Future.value();
  }
}
