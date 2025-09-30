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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Positioned(
      bottom:
          MediaQuery.of(context).padding.bottom + (isLandscape ? 120.h : 200.h),
      left: isLandscape ? 10.w : 20.w,
      right: isLandscape ? 10.w : 20.w,
      child: Column(
        children: [
          _buildZoomLevelIndicators(isLandscape),
          SizedBox(height: isLandscape ? 10.h : 20.h),
          _buildZoomSlider(isLandscape),
        ],
      ),
    );
  }

  Widget _buildZoomLevelIndicators(bool isLandscape) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [1.0, 2.0, 4.0, 8.0].map((zoomLevel) {
        return Obx(() {
          final isSelected =
              (controller.currentZoom.value - zoomLevel).abs() < 0.5;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isLandscape ? 4.w : 8.w),
            child: GestureDetector(
              onTap: () => controller.setZoomToLevel(zoomLevel),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 6.w : 12.w,
                  vertical: isLandscape ? 4.h : 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.yellow
                      : Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(
                    isLandscape ? 10.r : 20.r,
                  ),
                ),
                child: Text(
                  '${zoomLevel.toInt()}x',
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: isLandscape ? 8.sp : 14.sp,
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

  Widget _buildZoomSlider(bool isLandscape) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildZoomButton(
          icon: Icons.zoom_out,
          onPressed: () => controller.zoomOut(),
          isLandscape: isLandscape,
        ),
        SizedBox(width: isLandscape ? 10.w : 20.w),
        Expanded(
          child: Obx(
            () => SliderTheme(
              data: SliderTheme.of(Get.context!).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: isLandscape ? 4.r : 8.r,
                ),
                trackHeight: isLandscape ? 1.h : 2.h,
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
        SizedBox(width: isLandscape ? 10.w : 20.w),
        _buildZoomButton(
          icon: Icons.zoom_in,
          onPressed: () => controller.zoomIn(),
          isLandscape: isLandscape,
        ),
      ],
    );
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isLandscape,
  }) {
    return Container(
      width: isLandscape ? 30.w : 50.w,
      height: isLandscape ? 30.w : 50.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: isLandscape ? 14.sp : 24.sp,
        ),
      ),
    );
  }
}
