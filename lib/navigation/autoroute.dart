import 'package:auto_route/auto_route.dart';
import 'package:bookshelf/screens/books.dart';
import 'package:bookshelf/screens/details.dart';
import 'package:bookshelf/screens/welcome.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: WelcomeScreen, initial: true),
  AutoRoute(page: BooksScreen),
  AutoRoute(page: DetailsScreen),
])
class $AppRouter {}
