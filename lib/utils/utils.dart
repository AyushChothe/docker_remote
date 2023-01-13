import 'package:flutter/material.dart';

Future<void> processAPICall(
    BuildContext context, Future Function() func) async {
  final messenger = ScaffoldMessenger.of(context);
  final msg = await func();
  messenger.showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ),
  );
}
