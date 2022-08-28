import 'dart:io';

import 'package:bookshelf/navigation/delegate.dart';
import 'package:bookshelf/tracing/route_aware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../domain/data/books.dart';
import '../domain/models/book.dart';

const useDrawer = false;
const useAndroidBottomNavBar = false;
const useCupertinoBottomNavBar = true;
const useNavigationRail = true;

class BooksPage extends StatefulWidget {
  final Genre? filter;

  final DateTime timestamp = DateTime.now();

  BooksPage([this.filter, Key? key]) : super(key: key);

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final useDrawer = true;

  Future<List<Book>>? books;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    books = getBooks(widget.filter);
  }

  @override
  void didUpdateWidget(covariant BooksPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //replace with actual state management
    if (oldWidget != widget || oldWidget.filter != widget.filter) {
      books = getBooks(widget.filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: books,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return kIsWeb || Platform.isAndroid
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const CupertinoPageScaffold(
                  child: Center(child: CupertinoActivityIndicator()));
        }
        final data = snapshot.requireData;
        return SafeArea(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Material(
              child: ListTile(
                leading: data[index].icon,
                title: Text(data[index].title),
                onTap: () {
                  (Router.of(context).routerDelegate as BookshelfRouterDelegate)
                      .gotoBook(data[index].id);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ObservedState<BooksScreen> {
  @override
  String get stateName => 'Books';

  int _currentPage = 3;

  @override
  Widget build(BuildContext context) {
    const barItems = [
      BottomNavigationBarItem(
          icon: Icon(Icons.terrain_rounded), label: 'Fantasy'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined), label: 'Drama'),
      BottomNavigationBarItem(
          icon: Icon(Icons.star_outline), label: 'Classics'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'All'),
    ];

    final androidTabs = IndexedStack(index: _currentPage, children: [
      BooksPage(Genre.fantasy),
      BooksPage(Genre.classics),
      BooksPage(Genre.drama),
      BooksPage(),
    ]);

    return kIsWeb || Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: const Text('BookShelf'),
              automaticallyImplyLeading: true,
            ),
            // Drawer
            drawer: !useDrawer
                ? null
                : Drawer(
                    child: Column(
                      children: [
                        const DrawerHeader(child: Text('Genres')),
                        const Divider(),
                        for (final genre in Genre.values)
                          GestureDetector(
                            onTap: () {
                              setState(() => _currentPage = genre.index);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                genre.name.substring(0, 1).toUpperCase() +
                                    genre.name.substring(1),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        GestureDetector(
                            onTap: () {
                              setState(() => _currentPage = 3);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'All',
                              style: TextStyle(fontSize: 24),
                            )),
                      ],
                    ),
                  ),
            body: !useNavigationRail
                ? androidTabs
                : Row(
                    children: [
                      NavigationRail(
                        destinations: const [
                          NavigationRailDestination(
                              icon: Icon(Icons.terrain_rounded),
                              label: Text('Fantasy')),
                          NavigationRailDestination(
                              icon: Icon(Icons.favorite_border_outlined),
                              label: Text('Drama')),
                          NavigationRailDestination(
                              icon: Icon(Icons.star_outline),
                              label: Text('Classic')),
                          NavigationRailDestination(
                              icon: Icon(Icons.book), label: Text('All')),
                        ],
                        selectedIndex: _currentPage,
                        onDestinationSelected: (index) =>
                            setState(() => _currentPage = index),
                      ),
                      const VerticalDivider(thickness: 1),
                      Expanded(child: androidTabs),
                    ],
                  ),
            bottomNavigationBar: !useAndroidBottomNavBar
                ? null
                : BottomNavigationBar(
                    selectedItemColor: Colors.blueAccent,
                    unselectedItemColor: Colors.grey,
                    currentIndex: _currentPage,
                    items: barItems,
                    onTap: (index) => setState(() => _currentPage = index),
                  ),
          )
        : useCupertinoBottomNavBar
            ? CupertinoTabScaffold(
                tabBar: CupertinoTabBar(items: barItems),
                tabBuilder: (context, index) => CupertinoTabView(
                  builder: (_) => CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        middle: Text(
                          'BookShelf' +
                              (index < 3
                                  ? 'Filter: ' + Genre.values[index].name
                                  : ''),
                        ),
                      ),
                      child: BooksPage(index < 3 ? Genre.values[index] : null)),
                ),
              )
            : CupertinoPageScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('BookShelf'),
                ),
                child: BooksPage(),
              );
  }
}
