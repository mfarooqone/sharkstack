import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/camera_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_labels.dart';
import '../../utils/app_text_styles.dart';

/// Settings bottom sheet widget with camera configuration options
class CameraSettingsSheet extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraSettingsSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withValues(alpha: 0.5),
        child: Column(
          children: [
            const Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: AppColors.settingsBackground.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSettingItem(
                              title: AppLabels.oneHandedMode,
                              description: AppLabels.oneHandedModeDesc,
                              value: controller.oneHandedMode.value,
                              onChanged: (value) =>
                                  controller.oneHandedMode.value = value,
                            ),
                            _buildSettingItem(
                              title: AppLabels.autoSaveToDevice,
                              description: AppLabels.autoSaveDesc,
                              value: controller.autoSaveToDevice.value,
                              onChanged: (value) =>
                                  controller.autoSaveToDevice.value = value,
                            ),
                            _buildSettingItem(
                              title: AppLabels.preserveSettings,
                              description: AppLabels.preserveSettingsDesc,
                              value: controller.preserveSettings.value,
                              onChanged: (value) =>
                                  controller.preserveSettings.value = value,
                            ),
                            _buildLensSelection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.toggleSettingsSheet(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: AppColors.settingsBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: AppColors.white, size: 24),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            AppLabels.cameraSettings,
            style: AppTextStyle.titleLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
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
                  description,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.purple,
              inactiveThumbColor: AppColors.greyColor,
              inactiveTrackColor: AppColors.greyColor.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLensSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLabels.defaultCameraLens,
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          AppLabels.lensSelectionDesc,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.white.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: ['13mm', '24mm', '48mm', '77mm'].map((lens) {
            return Obx(() {
              final isSelected = controller.selectedLens.value == lens;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.setSelectedLens(lens),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.settingsBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: isSelected
                          ? Border.all(color: AppColors.white, width: 2)
                          : null,
                    ),
                    child: Text(
                      lens,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

/// Settings sheet widget optimized for landscape orientation
class CameraSettingsSheetLandscape extends StatelessWidget {
  final CameraRecordingController controller;

  const CameraSettingsSheetLandscape({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withValues(alpha: 0.5),
        child: Row(
          children: [
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.settingsBackground.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSettingItem(
                              title: AppLabels.oneHandedMode,
                              description: AppLabels.oneHandedModeDesc,
                              value: controller.oneHandedMode.value,
                              onChanged: (value) =>
                                  controller.oneHandedMode.value = value,
                            ),
                            _buildSettingItem(
                              title: AppLabels.autoSaveToDevice,
                              description: AppLabels.autoSaveDesc,
                              value: controller.autoSaveToDevice.value,
                              onChanged: (value) =>
                                  controller.autoSaveToDevice.value = value,
                            ),
                            _buildSettingItem(
                              title: AppLabels.preserveSettings,
                              description: AppLabels.preserveSettingsDesc,
                              value: controller.preserveSettings.value,
                              onChanged: (value) =>
                                  controller.preserveSettings.value = value,
                            ),
                            _buildLensSelection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 35.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.toggleSettingsSheet(),
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: const BoxDecoration(
                color: AppColors.settingsBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: AppColors.white, size: 24),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            AppLabels.cameraSettings,
            style: AppTextStyle.titleLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
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
                  description,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.purple,
              inactiveThumbColor: AppColors.greyColor,
              inactiveTrackColor: AppColors.greyColor.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLensSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLabels.defaultCameraLens,
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          AppLabels.lensSelectionDesc,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.white.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: ['13mm', '24mm', '48mm', '77mm'].map((lens) {
            return Obx(() {
              final isSelected = controller.selectedLens.value == lens;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.setSelectedLens(lens),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.settingsBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: isSelected
                          ? Border.all(color: AppColors.white, width: 2)
                          : null,
                    ),
                    child: Text(
                      lens,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
