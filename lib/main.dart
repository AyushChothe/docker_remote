import 'package:device_preview/device_preview.dart';
import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/pages/servers.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

// flutter run -d chrome --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await Isar.open([ServerSchema]);

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
      theme: FlexThemeData.dark(
        scheme: FlexScheme.bahamaBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          cardElevation: 0.5,
          elevatedButtonSchemeColor: SchemeColor.secondary,
          outlinedButtonSchemeColor: SchemeColor.secondary,
          tabBarIndicatorSchemeColor: SchemeColor.secondary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const ServersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
