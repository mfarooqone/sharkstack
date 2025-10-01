import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/camera_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_labels.dart';
import '../../utils/app_text_styles.dart';

/// Bottom action bar with upload, save toggle, and live streaming
class CameraActionBar extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraActionBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100.h,
        color: AppColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildUploadMedia(),
            _buildDivider(),
            _buildSaveToggle(),
            _buildDivider(),
            _buildLiveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadMedia() {
    return GestureDetector(
      onTap: () => controller.uploadMedia(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLabels.uploadMedia,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 13.h),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(Icons.logout, color: AppColors.white, size: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveToggle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLabels.saveToDevice,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => Transform.scale(
            scale: 0.7,
            child: Switch(
              value: controller.saveToDevice.value,
              onChanged: (value) => controller.toggleSaveToDevice(),
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.greyColor,
              inactiveThumbColor: AppColors.greyColor,
              inactiveTrackColor: AppColors.greyColor.withValues(alpha: 0.3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveButton() {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleLiveStreaming(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: controller.isLiveStreaming.value
                ? AppColors.red
                : AppColors.purple,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi, color: AppColors.white, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                AppLabels.live,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return VerticalDivider(
      width: 20.w,
      color: AppColors.white.withValues(alpha: 0.3),
    );
  }
}

/// Bottom action bar with upload, save toggle, and live streaming
class CameraActionBarLandscape extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraActionBarLandscape({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 00.w,
      bottom: 0,
      child: Container(
        width: 50.w,
        color: AppColors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLiveButton(),
            _buildSaveToggle(),
            _buildUploadMedia(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadMedia() {
    return GestureDetector(
      onTap: () => controller.uploadMedia(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLabels.uploadMedia,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 6.sp,
            ),
          ),
          SizedBox(height: 6.5.h),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(Icons.logout, color: AppColors.white, size: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveToggle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLabels.saveToDevice,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 6.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Obx(
          () => Transform.scale(
            scale: 0.35,
            child: Switch(
              value: controller.saveToDevice.value,
              onChanged: (value) => controller.toggleSaveToDevice(),
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.greyColor,
              inactiveThumbColor: AppColors.greyColor,
              inactiveTrackColor: AppColors.greyColor.withValues(alpha: 0.3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveButton() {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleLiveStreaming(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: controller.isLiveStreaming.value
                ? AppColors.red
                : AppColors.purple,
            borderRadius: BorderRadius.circular(12.5.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi, color: AppColors.white, size: 10.sp),
              SizedBox(width: 4.w),
              Text(
                AppLabels.live,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
