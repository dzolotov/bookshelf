import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../navigation/delegate.dart';

extension DialogExt on BuildContext {
  Future<bool?> showConfirmationDialog(
    Widget title,
    Widget content,
  ) async {
    if (!kIsWeb && Platform.isIOS) {
      return Navigator.of(this).push<bool?>(CupertinoDialogRoute(
          builder: (_) => CupertinoAlertDialog(
                title: title,
                content: content,
                actions: [
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(this).pop(true),
                  ),
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(this).pop(false),
                  ),
                ],
              ),
          context: this));
    } else {
      return Navigator.of(this).push<bool?>(
        DialogRoute(
          context: this,
          builder: (_) => AlertDialog(
            title: title,
            content: content,
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(this).pop(true),
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(this).pop(false),
              ),
            ],
          ),
        ),
      );
    }
  }
}
