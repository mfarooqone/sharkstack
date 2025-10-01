import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/camera_controller.dart';

/// Recording indicator widget shown during video recording
class CameraRecordingIndicator extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraRecordingIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Positioned(
      top: MediaQuery.of(context).padding.top + (isLandscape ? 5.h : 10.h),
      left: 0,
      right: 0,
      child: Center(
        child: Obx(
          () => Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 6.w : 12.w,
              vertical: isLandscape ? 4.h : 8.h,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(isLandscape ? 10.r : 20.r),
            ),
            child: Text(
              controller.formatDuration(controller.recordingDuration.value),
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 6.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
