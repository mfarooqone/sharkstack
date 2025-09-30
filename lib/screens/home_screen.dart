import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_labels.dart';
import '../utils/app_text_styles.dart';
import 'recording_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isLandscape ? 16.w : 20.w),
          child: Column(
            children: [
              // Top section with uploaders badge
              _buildTopSection(isLandscape),

              // Main content area
              Expanded(child: _buildMainContent(isLandscape)),

              // Record button
              _buildRecordButton(isLandscape),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(bool isLandscape) {
    return Row(
      children: [
        // Uploaders badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 10.w : 12.w,
            vertical: isLandscape ? 4.h : 6.h,
          ),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(isLandscape ? 16.r : 20.r),
          ),
          child: Text(
            '0 ${AppLabels.uploaders}',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              fontSize: isLandscape ? 5.sp : 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(bool isLandscape) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isLandscape ? 40.w : 20.w),
        child: Text(
          AppLabels.motivationalMessage,
          textAlign: TextAlign.center,
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.white,
            height: 1.4,
            fontSize: isLandscape ? 6.sp : 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildRecordButton(bool isLandscape) {
    return Center(
      child: Container(
        width: isLandscape ? 150.w : double.infinity,
        height: isLandscape ? 60.h : 60.h,
        margin: EdgeInsets.only(bottom: isLandscape ? 10.h : 20.h),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const RecordingScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isLandscape ? 60.r : 30.r),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.pink,
                  Color(0xFF8E24AA),
                ], // Pink to magenta gradient
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(isLandscape ? 60.r : 30.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_call_outlined,
                    color: AppColors.white,
                    size: isLandscape ? 10.sp : 24.sp,
                  ),
                  SizedBox(width: isLandscape ? 6.w : 8.w),
                  Text(
                    AppLabels.record,
                    style: AppTextStyle.titleMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isLandscape ? 6.sp : 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
