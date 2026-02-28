import 'package:flutter/material.dart';
import 'package:splitease_test/core/theme/laser_theme.dart';
export 'package:splitease_test/core/theme/laser_theme.dart' show LaserTheme, LaserColors;

// ─── AppColors: Laser Aqua alias for backward compatibility with admin screens ─
class AppColors {
  // Primary (mapped to Laser Aqua)
  static const Color primary = LaserColors.primary;
  static const Color primaryLight = LaserColors.primaryStart;
  static const Color primaryDark = LaserColors.primaryEnd;

  // Gradients
  static const List<Color> primaryGradient = LaserColors.primaryGradient;
  static const List<Color> introGradient = LaserColors.introGradient;

  // Light theme
  static const Color lightBg = LaserColors.lightBg;
  static const Color lightSurface = LaserColors.lightSurface;
  static const Color lightSurfaceVariant = LaserColors.lightSurfaceVariant;
  static const Color lightText = LaserColors.lightText;
  static const Color lightSubtext = LaserColors.lightSubtext;

  // Dark theme
  static const Color darkBg = LaserColors.darkBg;
  static const Color darkSurface = LaserColors.darkSurface;
  static const Color darkSurfaceVariant = LaserColors.darkSurfaceVariant;
  static const Color darkText = LaserColors.textLight;
  static const Color darkSubtext = LaserColors.subtextLight;

  // Status
  static const Color paid = LaserColors.accentGreen;
  static const Color paidBg = LaserColors.accentGreenBg;
  static const Color pending = LaserColors.accentAmber;
  static const Color pendingBg = LaserColors.accentAmberBg;
  static const Color error = LaserColors.accentRed;

  // Admin accent
  static const Color adminAccent = LaserColors.adminAccent;
  static const List<Color> adminGradient = LaserColors.adminGradient;
}

// ─── AppTheme: Delegates to LaserTheme ────────────────────────────────────────
class AppTheme {
  static const double borderRadius = 20.0;
  static const double padding = 20.0;
  static const double paddingSmall = 12.0;

  static ThemeData light() => LaserTheme.light();
  static ThemeData dark() => LaserTheme.dark();
}
