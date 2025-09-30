import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/recording_screen.dart';
import 'utils/app_colors.dart';

/// Task Shark App Entry Point
///
/// A Flutter video recording application with camera controls,
/// zoom functionality, and settings management.
void main() {
  runApp(const TaskSharkApp());
}

/// Main Application Widget
///
/// Configures the app with GetX state management, responsive design,
/// and dark theme with pink accent colors.
class TaskSharkApp extends StatelessWidget {
  const TaskSharkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Task Shark',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(),
          initialRoute: '/',
          getPages: _buildRoutes(),
        );
      },
    );
  }

  /// Build app theme with dark colors and pink accents
  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.pink,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Define app routes
  List<GetPage> _buildRoutes() {
    return [
      GetPage(name: '/', page: () => const HomeScreen()),
      GetPage(name: '/recording', page: () => const RecordingScreen()),
    ];
  }
}
