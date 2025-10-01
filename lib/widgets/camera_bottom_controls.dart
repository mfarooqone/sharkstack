import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/camera_controller.dart';

/// Bottom controls widget with settings, record button, and camera info
class CameraBottomControls extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraBottomControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 110.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSettingsButton(),
          _buildRecordButton(),
          _buildCameraInfoButton(),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.settings_outlined, color: Colors.white, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton() {
    return GestureDetector(
      onTap: () {
        if (controller.isRecording.value) {
          controller.stopRecording();
        } else {
          controller.startRecording();
        }
      },
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.5),
            width: 4,
          ),
        ),
        child: Center(
          child: controller.isRecording.value
              ? Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                )
              : Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCameraInfoButton() {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              '24mm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom controls widget with settings, record button, and camera info
class CameraBottomControlsLandscape extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraBottomControlsLandscape({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 60.h,
      right: 20.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCameraInfoButton(),
          SizedBox(height: 4.h),
          _buildRecordButton(),
          SizedBox(height: 4.h),
          _buildSettingsButton(),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.5.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 6.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.settings_outlined, color: Colors.white, size: 8.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton() {
    return GestureDetector(
      onTap: () {
        if (controller.isRecording.value) {
          controller.stopRecording();
        } else {
          controller.startRecording();
        }
      },
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Center(
          child: controller.isRecording.value
              ? Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                )
              : Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCameraInfoButton() {
    return GestureDetector(
      onTap: () => controller.toggleSettingsSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.5.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 8.sp),
            SizedBox(width: 4.w),
            Text(
              '24mm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 6.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
