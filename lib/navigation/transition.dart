import 'package:flutter/widgets.dart';

import '../main.dart';

class BookshelfTransitionDelegate extends TransitionDelegate {
  @override
  Iterable<RouteTransitionRecord> resolve(
      {required List<RouteTransitionRecord> newPageRouteHistory,
      required Map<RouteTransitionRecord?, RouteTransitionRecord>
          locationToExitingPageRoute,
      required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
          pageRouteToPagelessRoutes}) {
    print('Resolving');
    logger.i('Calling transition delegate');
    List<RouteTransitionRecord> newHistory = [];
    for (var element in newPageRouteHistory) {
      if (element.isWaitingForEnteringDecision) {
        logger.i('Element $element is marked for push');
        element.markForPush();
        newHistory.add(element);
      }
      if (element.isWaitingForExitingDecision) {
        logger.i('Element $element is marked for pop');
        element.markForPop();
        newHistory.add(element);
      }
    }
    return newHistory;
  }
}
