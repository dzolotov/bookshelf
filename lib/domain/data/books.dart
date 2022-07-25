import 'package:flutter/material.dart';

import '../models/book.dart';

final booksMock = <Book>[
  Book(
      id: 1,
      icon: const Icon(Icons.cloud),
      title: "Cloud Atlas",
      genre: Genre.drama),
  Book(
    id: 2,
    icon: const Icon(Icons.cases),
    title: "Strange Case of Dr Jekyll and Mr Hyde",
    genre: Genre.drama,
  ),
  Book(
      id: 3,
      icon: const Icon(Icons.water_outlined),
      title: "The Alchemist",
      genre: Genre.drama),
  Book(
    id: 4,
    icon: const Icon(Icons.view_in_ar),
    title: "Alice's Adventures in Wonderland",
    genre: Genre.fantasy,
  ),
  Book(
    id: 5,
    icon: const Icon(Icons.umbrella),
    title: "Mary Poppins",
    genre: Genre.fantasy,
  ),
  Book(
    id: 6,
    icon: const Icon(Icons.watch_later),
    title: "The Time Machine",
    genre: Genre.classics,
  ),
  Book(
    id: 7,
    icon: const Icon(Icons.book_online),
    title: "Peter Pan",
    genre: Genre.classics,
  ),
];

Future<Book> getBook(int id) async {
  return booksMock.where((element) => element.id == id).first;
}

Future<List<Book>> getBooks(Genre? genre) async {
  if (genre == null) return booksMock;
  return Future.value(
      booksMock.where((element) => element.genre == genre).toList());
}

void removeBook(int id) {
  booksMock.removeWhere((element) => element.id == id);
}

void takeBook(int id, String who) {
  final index = booksMock.indexWhere((element) => element.id == id);
  booksMock[index].takenBy = who;
}

void returnBook(int id) {
  final index = booksMock.indexWhere((element) => element.id == id);
  booksMock[index].takenBy = null;
}
