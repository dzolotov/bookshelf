import 'package:flutter/widgets.dart';

abstract class ObservedState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  String get stateName => 'unknown';
  @override
  void didPopNext() => debugPrint('Did pop next [$stateName]');

  @override
  void didPushNext() => debugPrint('Did push next [$stateName]');

  @override
  void didPop() => debugPrint('Did pop [$stateName]');

  @override
  void didPush() => debugPrint('Did push [$stateName]');
}
