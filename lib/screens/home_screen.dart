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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

        // Settings or menu button
        IconButton(
          onPressed: () {
            // Show settings or menu
          },
          icon: const Icon(Icons.menu, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Motivational message
          Text(
            AppLabels.motivationalMessage,
            textAlign: TextAlign.center,
            style: AppTextStyle.titleMedium.copyWith(
              color: AppColors.white,
              height: 1.4,
            ),
          ),

          SizedBox(height: 40.h),

          // Additional content or features can be added here
          _buildFeatureCards(),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      children: [
        _buildFeatureCard(
          icon: Icons.video_library,
          title: AppLabels.videoLibrary,
          subtitle: AppLabels.manageRecordings,
          onTap: () {
            // Navigate to video library
          },
        ),

        SizedBox(height: 16.h),

        _buildFeatureCard(
          icon: Icons.cloud_upload,
          title: AppLabels.uploadHistory,
          subtitle: AppLabels.viewUploads,
          onTap: () {
            // Navigate to upload history
          },
        ),

        SizedBox(height: 16.h),

        _buildFeatureCard(
          icon: Icons.analytics,
          title: AppLabels.analytics,
          subtitle: AppLabels.trackProgress,
          onTap: () {
            // Navigate to analytics
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.pink.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: AppColors.pink, size: 24.sp),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.titleMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white.withValues(alpha: 0.5),
              size: 16.sp,
            ),
          ],
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
              colors: [AppColors.pink, AppColors.purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam, color: AppColors.white, size: 24.sp),
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
