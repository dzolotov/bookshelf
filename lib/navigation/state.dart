import 'package:flutter/foundation.dart';

class NavigationState with ChangeNotifier {
  bool _isWelcome;
  int? _bookId;
  NavigationState(this._isWelcome, this._bookId);
  bool get isWelcome => _isWelcome;
  int? get bookId => _bookId;
  set isWelcome(bool val) {
    _isWelcome = val;
    notifyListeners();
  }

  set bookId(int? val) {
    _bookId = val;
    notifyListeners();
  }

  @override
  String toString() => "Welcome: $_isWelcome, book: $_bookId";
}
