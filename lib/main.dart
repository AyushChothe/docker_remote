import 'package:docker_remote/pages/home.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docker Remote',
      theme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
