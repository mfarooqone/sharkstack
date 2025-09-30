import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/camera_controller.dart';

/// Bottom controls widget with settings, record button, and camera info
class CameraBottomControls extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraBottomControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Positioned(
      bottom:
          MediaQuery.of(context).padding.bottom + (isLandscape ? 60.h : 110.h),
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSettingsButton(isLandscape),
          _buildRecordButton(isLandscape),
          _buildCameraInfoButton(isLandscape),
        ],
      ),
    );
  }

  Widget _buildSettingsButton(bool isLandscape) {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 12.w : 20.w,
          vertical: isLandscape ? 6.h : 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(isLandscape ? 15.r : 25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 8.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: isLandscape ? 4.w : 8.w),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: isLandscape ? 10.sp : 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton(bool isLandscape) {
    return GestureDetector(
      onTap: () {
        if (controller.isRecording.value) {
          controller.stopRecording();
        } else {
          controller.startRecording();
        }
      },
      child: Container(
        width: isLandscape ? 40.w : 60.w,
        height: isLandscape ? 40.w : 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.5),
            width: isLandscape ? 2 : 4,
          ),
        ),
        child: Center(
          child: controller.isRecording.value
              ? Container(
                  width: isLandscape ? 20.w : 30.w,
                  height: isLandscape ? 20.w : 30.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      isLandscape ? 2.r : 4.r,
                    ),
                  ),
                )
              : Container(
                  width: isLandscape ? 40.w : 60.w,
                  height: isLandscape ? 40.w : 60.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCameraInfoButton(bool isLandscape) {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 12.w : 20.w,
          vertical: isLandscape ? 6.h : 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(isLandscape ? 15.r : 25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: isLandscape ? 10.sp : 16.sp,
            ),
            SizedBox(width: isLandscape ? 4.w : 8.w),
            Text(
              '24mm',
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 8.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
