import 'package:flutter/cupertino.dart';

class ShelfNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async =>
      debugPrint("Did push $route over {$previousRoute}");

  @override
  void didStopUserGesture() => debugPrint("Did stop user gesture");

  @override
  void didStartUserGesture(
          Route<dynamic> route, Route<dynamic>? previousRoute) =>
      debugPrint("Did start user gesture $route over $previousRoute");

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      debugPrint("Did replace $newRoute over $oldRoute");

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      debugPrint("Did remove $route over $previousRoute");

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      debugPrint("Did pop $route to $previousRoute");
}
