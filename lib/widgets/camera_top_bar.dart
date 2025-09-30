import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/camera_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

/// Top bar widget with close button and upload indicator
class CameraTopBar extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildCloseButton(), _buildUploadIndicator()],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.close, color: AppColors.white, size: 24.sp),
      ),
    );
  }

  Widget _buildUploadIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Badge(
            backgroundColor: AppColors.red,
            label: Text(
              controller.uploadCount.value.toString(),
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(Icons.logout, color: AppColors.white, size: 24.sp),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.w),
        Container(
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Center(
              child: Text(
                'SS2',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
