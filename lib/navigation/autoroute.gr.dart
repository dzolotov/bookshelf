// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i5;

import '../screens/books.dart' as _i2;
import '../screens/details.dart' as _i3;
import '../screens/welcome.dart' as _i1;
import 'models.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    WelcomeScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.WelcomeScreen());
    },
    BooksScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.BooksScreen());
    },
    DetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsScreenRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.DetailsScreen(args.bookId, key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(WelcomeScreenRoute.name, path: '/'),
        _i4.RouteConfig(BooksScreenRoute.name, path: '/books-screen'),
        _i4.RouteConfig(DetailsScreenRoute.name, path: '/details-screen')
      ];
}

/// generated route for
/// [_i1.WelcomeScreen]
class WelcomeScreenRoute extends _i4.PageRouteInfo<void> {
  const WelcomeScreenRoute() : super(WelcomeScreenRoute.name, path: '/');

  static const String name = 'WelcomeScreenRoute';
}

/// generated route for
/// [_i2.BooksScreen]
class BooksScreenRoute extends _i4.PageRouteInfo<void> {
  const BooksScreenRoute()
      : super(BooksScreenRoute.name, path: '/books-screen');

  static const String name = 'BooksScreenRoute';
}

/// generated route for
/// [_i3.DetailsScreen]
class DetailsScreenRoute extends _i4.PageRouteInfo<DetailsScreenRouteArgs> {
  DetailsScreenRoute({required _i6.BookId bookId, _i7.Key? key})
      : super(DetailsScreenRoute.name,
            path: '/details-screen',
            args: DetailsScreenRouteArgs(bookId: bookId, key: key));

  static const String name = 'DetailsScreenRoute';
}

class DetailsScreenRouteArgs {
  const DetailsScreenRouteArgs({required this.bookId, this.key});

  final _i6.BookId bookId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'DetailsScreenRouteArgs{bookId: $bookId, key: $key}';
  }
}
