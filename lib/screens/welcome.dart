import 'dart:io';

import 'package:bookshelf/navigation/controller.dart';
import 'package:bookshelf/navigation/routes.dart';
import 'package:bookshelf/tracing/route_aware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.cyan,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Text(
                "Welcome to bookshelf",
                style: TextStyle(fontSize: 42, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () => context
                    .read<NavigationController>()
                    .navigateTo(Routes.books),
                child: const Text(
                  "Go",
                  style: TextStyle(fontSize: 28),
                ),
              )
            ])),
      );
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ObservedState<WelcomeScreen> {
  @override
  String get stateName => "WelcomePage";

  @override
  void initState() {
    super.initState();
    //или after_layout package
    WidgetsBinding.instance!.endOfFrame.then((value) {
      context
          .read<RouteObserver>()
          .subscribe(this, ModalRoute.of(context) as PageRoute);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Platform.isAndroid
      ? const Scaffold(
          body: WelcomePage(),
        )
      : const CupertinoPageScaffold(child: WelcomePage());
}
