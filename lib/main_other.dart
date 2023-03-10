import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/pages/servers.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await Isar.open([ServerSchema], inspector: false);
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => ProviderScope(
        overrides: [isarProvider.overrideWith((ref) => isar)],
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docker Remote',
      theme: theme,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const ServersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
