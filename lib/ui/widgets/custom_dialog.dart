import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  static const String messageButton = "Accept";
  const CustomDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(messageButton))
            ],
            content: Text(message),
          )
        : CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(messageButton)),
            ],
            content: Text(message),
          );
  }
}
