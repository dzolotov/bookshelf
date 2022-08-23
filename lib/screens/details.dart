import 'dart:io';

import 'package:bookshelf/navigation/controller.dart';
import 'package:bookshelf/utils/confirmation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/data/books.dart';
import '../domain/models/book.dart';
import '../navigation/models.dart';

class DetailsPage extends StatefulWidget {
  final Book book;

  const DetailsPage({required this.book, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool wasChanges = false;

  bool modalMode = true;

  String rented = '';

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return WillPopScope(
      onWillPop: () async {
        if (!wasChanges) return true;
        if (modalMode) {
          final result = Platform.isIOS
              ? await showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                          onPressed: () {
                            context.read<NavigationController>().pop(true);
                          },
                          child: const Text("OK")),
                      CupertinoActionSheetAction(
                          onPressed: () {
                            context.read<NavigationController>().pop(false);
                          },
                          child: const Text("Cancel"))
                    ],
                  ),
                )
              : await showModalBottomSheet(
                  context: context,
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () =>
                            context.read<NavigationController>().pop(true),
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<NavigationController>().pop(false),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
          return result;
        } else {
          //функция-расширение, определена в confirmation_dialog.dart
          return await context.showConfirmationDialog(
                const Text('Are you sure?'),
                const Text('You can lose your changes'),
              ) ==
              true;
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            Material(
              child: ListTile(
                leading: book.icon,
                title: const Text('Book icon'),
              ),
            ),
            Material(
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete"),
                onTap: () async {
                  final result = await context.showConfirmationDialog(
                    const Text("Are you sure to delete?"),
                    const Text('Do you really want to delete this book?'),
                  );
                  if (result == true) {
                    removeBook(book.id);
                    context
                        .read<NavigationController>()
                        .pop(); //перейти в список
                  }
                },
              ),
            ),
            Material(
              child: ListTile(
                leading: const Icon(Icons.launch),
                title: kIsWeb || Platform.isAndroid
                    ? TextField(
                        onSubmitted: (_) => setState(() => wasChanges = false),
                        onChanged: (_) => setState(() =>
                            wasChanges = true), //mark for back gesture popup
                        decoration:
                            const InputDecoration(hintText: 'Rent book'),
                      )
                    : CupertinoTextField(
                        suffix: wasChanges
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    wasChanges = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                              )
                            : null,
                        onSubmitted: (_) {
                          debugPrint('On Submitted');
                          setState(() => wasChanges = false);
                        },
                        onChanged: (_) {
                          setState(() => wasChanges = true);
                        }, //mark for back gesture popup
                        placeholder: 'Rent book',
                      ),
              ),
            ),
            Material(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Choose book return date'),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 30),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final BookId bookId;

  const DetailsScreen(this.bookId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = getBook(bookId.id);
    return FutureBuilder<Book>(
      future: book,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return kIsWeb || Platform.isAndroid
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const CupertinoPageScaffold(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
        }
        return kIsWeb || Platform.isAndroid
            ? Scaffold(
                appBar: AppBar(title: Text(snapshot.requireData.title)),
                body: DetailsPage(
                  book: snapshot.requireData,
                ),
              )
            : CupertinoPageScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                navigationBar: CupertinoNavigationBar(
                  middle: Text(snapshot.requireData.title),
                ),
                child: DetailsPage(
                  book: snapshot.requireData,
                ),
              );
      },
    );
  }
}
