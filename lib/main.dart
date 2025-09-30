import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/recording_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const TaskSharkApp());
}

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

  List<GetPage> _buildRoutes() {
    return [
      GetPage(name: '/', page: () => const HomeScreen()),
      GetPage(name: '/recording', page: () => const RecordingScreen()),
    ];
  }
}
