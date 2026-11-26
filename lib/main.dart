import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/home_pages.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholder Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.forest,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.forest,
          onPrimary: AppColors.cream,
          primaryContainer: AppColors.sand,
          onPrimaryContainer: AppColors.charcoal,
          secondary: AppColors.brown,
          onSecondary: AppColors.cream,
          secondaryContainer: AppColors.sand,
          onSecondaryContainer: AppColors.charcoal,
          tertiary: AppColors.brown,
          onTertiary: AppColors.cream,
          surface: AppColors.cream,
          onSurface: AppColors.charcoal,
          surfaceContainerLowest: AppColors.cream,
          surfaceContainerLow: AppColors.cream,
          surfaceContainer: AppColors.sand,
          surfaceContainerHighest: AppColors.sand,
          outline: AppColors.brown,
        ),
        scaffoldBackgroundColor: AppColors.sand,
        cardTheme: CardThemeData(
          color: AppColors.cream,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: AppColors.sand),
          ),
        ),
        dividerColor: AppColors.sand,
      ),
      home: const HomePages(),
      debugShowCheckedModeBanner: false,
    );
  }
}
