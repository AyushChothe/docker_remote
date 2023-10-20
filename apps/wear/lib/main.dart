import 'package:common/utils/constants.dart';
import 'package:docker_remote_wear/watch_pages/watch_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// flutter run -d chrome --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyWearApp()));
}

class MyWearApp extends StatelessWidget {
  const MyWearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docker Remote',
      theme: theme.copyWith(
        visualDensity: VisualDensity.compact,
        listTileTheme: const ListTileThemeData(dense: true),
      ),
      home: const WatchDashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
