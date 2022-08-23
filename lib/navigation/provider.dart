import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';

class DebugRouteInformationProvider extends PlatformRouteInformationProvider {
  DebugRouteInformationProvider()
      : super(
            initialRouteInformation: RouteInformation(
                location: PlatformDispatcher.instance.defaultRouteName));

  @override
  Future<bool> didPushRoute(String route) {
    logger.d('Platform reports $route');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    logger.d('Platform reports routeinformation: $routeInformation');
    return super.didPushRouteInformation(routeInformation);
  }
}
