import 'package:flutter/material.dart';

Future<void> processAPICall(BuildContext context, Future Function() func,
    {bool confirmation = false}) async {
  final messenger = ScaffoldMessenger.of(context);
  bool? perform = true;

  if (confirmation) {
    perform = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Are you sure?"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No")),
          OutlinedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"))
        ],
      ),
    );
  }
  if (perform == true) {
    final processing = messenger.showSnackBar(
      const SnackBar(
        content: Text("Processing"),
      ),
    );

    final msg = await func();
    processing.close();

    messenger.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
