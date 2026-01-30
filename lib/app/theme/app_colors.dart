import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Blue / White theme
  static const Color primary = Color(0xFF1E6BFF);
  static const Color primaryDark = Color(0xFF1453D8);
  static const Color primaryLight = Color(0xFF7AA6FF);

  // Secondary Colors (blue accents)
  static const Color secondary = Color(0xFF00A6FB);
  static const Color secondaryLight = Color(0xFF6BCBFF);

  // Accent Colors (soft blues)
  static const Color accent1 = Color(0xFF4CC9F0);
  static const Color accent2 = Color(0xFF90CAF9);
  static const Color accent3 = Color(0xFFB3E5FC);

  // Neutral Colors
  static const Color background = Color(0xFFF7F9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF2F6FF);
  static const Color inputFill = Color(0xFFF1F4FB);

  // Text Colors
  static const Color textPrimary = Color(0xFF1C2430);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF212121);
  static const Color textMuted = Color(0xFF757575);

  // Border & Divider
  static const Color border = Color(0xFFE3E8F0);
  static const Color divider = Color(0xFFEFF3FA);

  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Login/Auth Colors (Blue theme)
  static const Color authPrimary = Color(0xFF1E6BFF);

  // Complaint Status Colors (used as Open/Resolved)
  static const Color openColor = Color(0xFF1E6BFF); // Open
  static const Color resolvedColor = Color(0xFF22C55E); // Resolved
  static const Color claimedColor = Color(0xFF9E9E9E);

  // Onboarding Colors (blue gradients)
  static const Color onboarding1Primary = Color(0xFF1E6BFF);
  static const Color onboarding1Secondary = Color(0xFF5A8CFF);
  static const Color onboarding2Primary = Color(0xFF2D8CFF);
  static const Color onboarding2Secondary = Color(0xFF6BB6FF);
  static const Color onboarding3Primary = Color(0xFF0081FF);
  static const Color onboarding3Secondary = Color(0xFF4FC3FF);

  // White with opacity
  static const Color white90 = Color(0xE6FFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);

  // Black with opacity
  static const Color black20 = Color(0x33000000);

  // Text secondary with opacity
  static const Color textSecondary60 = Color(0x996B7280);
  static const Color textSecondary50 = Color(0x806B7280);

  // Complaint Status Gradients (Open/Resolved)
  static const LinearGradient openGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E6BFF), Color(0xFF2E7BFF)],
  );

  static const LinearGradient resolvedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
  );

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E6BFF), Color(0xFF2D8CFF)],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4CC9F0), Color(0xFF90CAF9)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF7F9FF), Color(0xFFFFFFFF)],
  );

  // Onboarding Gradients
  static const LinearGradient onboarding1Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [onboarding1Primary, onboarding1Secondary],
  );

  static const LinearGradient onboarding2Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [onboarding2Primary, onboarding2Secondary],
  );

  static const LinearGradient onboarding3Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [onboarding3Primary, onboarding3Secondary],
  );

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1A1F26);
  static const Color darkSurfaceVariant = Color(0xFF242A32);
  static const Color darkInputFill = Color(0xFF1E242C);

  // Dark Text Colors
  static const Color darkTextPrimary = Color(0xFFE8EAED);
  static const Color darkTextSecondary = Color(0xFFB4B8BB);
  static const Color darkTextTertiary = Color(0xFF7C8186);

  // Dark Border & Divider
  static const Color darkBorder = Color(0xFF2D3339);
  static const Color darkDivider = Color(0xFF252B33);

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x141E6BFF), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(color: Color(0x401E6BFF), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> softShadow = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(color: black20, blurRadius: 30, offset: Offset(0, 15)),
    BoxShadow(color: white30, blurRadius: 20, offset: Offset(0, 5)),
  ];

  // Dark Theme Shadows
  static const List<BoxShadow> darkCardShadow = [
    BoxShadow(color: Color(0x26000000), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> darkSoftShadow = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
}


