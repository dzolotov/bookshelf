import 'package:bookshelf/navigation/paths.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

//Transform state <-> URL
class BooksShelfRouteInformationParser
    extends RouteInformationParser<NavigationStateDTO> {
  @override
  Future<NavigationStateDTO> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return Future.value(NavigationStateDTO.welcome());
    }
    switch (uri.pathSegments[0]) {
      case Paths.books:
        return Future.value(NavigationStateDTO.books());
      case Paths.book:
        return Future.value(
            NavigationStateDTO.book(int.parse(uri.pathSegments[1])));
      default:
        return Future.value(NavigationStateDTO.welcome());
    }
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationStateDTO configuration) {
    if (configuration.welcome) {
      return const RouteInformation(location: Paths.welcome);
    }
    if (configuration.bookId == null) {
      return const RouteInformation(location: "/${Paths.books}");
    }
    return RouteInformation(location: "/${Paths.book}/${configuration.bookId}");
  }
}
