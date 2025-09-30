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
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Top section with uploaders badge
              _buildTopSection(),

              // Main content area
              Expanded(child: _buildMainContent()),

              // Record button
              _buildRecordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      children: [
        // Uploaders badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '0 ${AppLabels.uploaders}',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Text(
        AppLabels.motivationalMessage,
        textAlign: TextAlign.center,
        style: AppTextStyle.titleMedium.copyWith(
          color: AppColors.white,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildRecordButton() {
    return Container(
      width: double.infinity,
      height: 60.h,
      margin: EdgeInsets.only(bottom: 20.h),
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => const RecordingScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
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
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call_outlined,
                  color: AppColors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  AppLabels.record,
                  style: AppTextStyle.titleMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
