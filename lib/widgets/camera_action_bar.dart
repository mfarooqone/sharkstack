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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: isLandscape ? 60.h : 100.h,
        color: AppColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildUploadMedia(isLandscape),
            _buildDivider(isLandscape),
            _buildSaveToggle(isLandscape),
            _buildDivider(isLandscape),
            _buildLiveButton(isLandscape),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadMedia(bool isLandscape) {
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
              fontSize: isLandscape ? 8.sp : 12.sp,
            ),
          ),
          SizedBox(height: isLandscape ? 6.h : 13.h),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.logout,
              color: AppColors.white,
              size: isLandscape ? 14.sp : 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveToggle(bool isLandscape) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLabels.saveToDevice,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: isLandscape ? 8.sp : 12.sp,
          ),
        ),
        SizedBox(height: isLandscape ? 4.h : 8.h),
        Obx(
          () => Transform.scale(
            scale: isLandscape ? 0.5 : 0.7,
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

  Widget _buildLiveButton(bool isLandscape) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleLiveStreaming(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 12.w : 20.w,
            vertical: isLandscape ? 6.h : 12.h,
          ),
          decoration: BoxDecoration(
            color: controller.isLiveStreaming.value
                ? AppColors.red
                : AppColors.purple,
            borderRadius: BorderRadius.circular(isLandscape ? 15.r : 25.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi,
                color: AppColors.white,
                size: isLandscape ? 12.sp : 20.sp,
              ),
              SizedBox(width: isLandscape ? 4.w : 8.w),
              Text(
                AppLabels.live,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape ? 8.sp : 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isLandscape) {
    return VerticalDivider(
      width: isLandscape ? 12.w : 20.w,
      color: AppColors.white.withValues(alpha: 0.3),
    );
  }
}
