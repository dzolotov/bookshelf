import 'dart:io';

import 'package:bookshelf/navigation/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

extension DialogExt on BuildContext {
  Future<bool?> showConfirmationDialog(
    Widget title,
    Widget content,
  ) async {
    final controller = read<NavigationController>();
    if (Platform.isIOS) {
      return controller.pushDialog<bool?>(CupertinoDialogRoute(
          builder: (_) => CupertinoAlertDialog(
                title: title,
                content: content,
                actions: [
                  CupertinoButton(
                      child: const Text('OK'),
                      onPressed: () => read<NavigationController>().pop(true)),
                  CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => read<NavigationController>().pop(false)),
                ],
              ),
          context: this));
    } else {
      return controller.pushDialog<bool?>(
        DialogRoute(
          context: this,
          builder: (_) => AlertDialog(
            title: title,
            content: content,
            actions: [
              TextButton(
                  child: const Text('OK'),
                  onPressed: () => read<NavigationController>().pop(true)),
              TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => read<NavigationController>().pop(false)),
            ],
          ),
        ),
      );
    }
  }
}
