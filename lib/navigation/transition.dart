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
    logger.i('Calling transition delegate');
    for (var element in newPageRouteHistory) {
      if (element.isWaitingForEnteringDecision) {
        logger.i('Element $element is marked for push');
        element.markForPush();
      }
      if (element.isWaitingForExitingDecision) {
        // print('Element $element is marked for pop');
        element.markForPop();
      }
    }
    return newPageRouteHistory;
  }
}
