import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = FlexThemeData.dark(
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
);
