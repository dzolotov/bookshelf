import 'dart:io';

import 'package:bookshelf/navigation/paths.dart';
import 'package:bookshelf/tracing/route_aware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

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
                onPressed: () => GoRouter.of(context).pushNamed(Paths.books),
                child: const Text(
                  "Go",
                  style: TextStyle(fontSize: 28),
                ),
              )
            ],
          ),
        ),
      );
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ObservedState<WelcomeScreen> {
  @override
  String get stateName => "WelcomePage";

  @override
  Widget build(BuildContext context) => kIsWeb || Platform.isAndroid
      ? const Scaffold(
          body: WelcomeWidget(),
        )
      : const CupertinoPageScaffold(child: WelcomeWidget());
}
