import 'package:flutter/widgets.dart';

enum Genre {
  fantasy,
  drama,
  classics,
}

class Book {
  int id;
  Icon icon;
  String title;
  Genre genre;
  String? takenBy;

  Book({
    required this.id,
    required this.icon,
    required this.title,
    required this.genre,
    this.takenBy,
  });
}
