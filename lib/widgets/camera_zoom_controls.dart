import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/camera_controller.dart';

/// Zoom controls widget with level indicators and slider
class CameraZoomControls extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraZoomControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 200.h,
      left: 20.w,
      right: 20.w,
      child: Column(
        children: [
          _buildZoomLevelIndicators(),
          SizedBox(height: 20.h),
          _buildZoomSlider(),
        ],
      ),
    );
  }

  Widget _buildZoomLevelIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [1.0, 2.0, 4.0, 8.0].map((zoomLevel) {
        return Obx(() {
          final isSelected =
              (controller.currentZoom.value - zoomLevel).abs() < 0.5;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GestureDetector(
              onTap: () => controller.setZoomToLevel(zoomLevel),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.yellow
                      : Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${zoomLevel.toInt()}x',
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildZoomSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildZoomButton(
          icon: Icons.zoom_out,
          onPressed: () => controller.zoomOut(),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Obx(
            () => SliderTheme(
              data: SliderTheme.of(Get.context!).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                trackHeight: 2.h,
              ),
              child: Slider(
                value: controller.currentZoom.value,
                min: controller.minZoom.value,
                max: controller.maxZoom.value,
                onChanged: (value) => controller.setZoom(value),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        _buildZoomButton(
          icon: Icons.zoom_in,
          onPressed: () => controller.zoomIn(),
        ),
      ],
    );
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }
}

/// Zoom controls widget with level indicators and slider
class CameraZoomControlsLandscape extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraZoomControlsLandscape({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).padding.left + 20.w,
      top: MediaQuery.of(context).padding.top + 20.h,
      bottom: MediaQuery.of(context).padding.bottom + 20.h,
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildZoomLevelIndicators(),
            SizedBox(height: 10.h),
            _buildZoomSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomLevelIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [1.0, 2.0, 4.0, 8.0].map((zoomLevel) {
        return Obx(() {
          final isSelected =
              (controller.currentZoom.value - zoomLevel).abs() < 0.5;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () => controller.setZoomToLevel(zoomLevel),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.yellow
                      : Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${zoomLevel.toInt()}x',
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildZoomSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildZoomButton(
          icon: Icons.zoom_out,
          onPressed: () => controller.zoomOut(),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Obx(
            () => SliderTheme(
              data: SliderTheme.of(Get.context!).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.r),
                trackHeight: 1.h,
              ),
              child: Slider(
                value: controller.currentZoom.value,
                min: controller.minZoom.value,
                max: controller.maxZoom.value,
                onChanged: (value) => controller.setZoom(value),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        _buildZoomButton(
          icon: Icons.zoom_in,
          onPressed: () => controller.zoomIn(),
        ),
      ],
    );
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 12.sp),
      ),
    );
  }
}
