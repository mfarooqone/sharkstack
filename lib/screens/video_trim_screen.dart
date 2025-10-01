import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_editor/video_editor.dart';

import '../controllers/video_trim_controller.dart';
import '../utils/app_colors.dart';

/// Video Trimming Screen
///
/// Allows users to trim the recorded video before saving
/// Switches between portrait and landscape views based on orientation
class VideoTrimScreen extends StatelessWidget {
  final String videoPath;

  const VideoTrimScreen({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    final VideoTrimController controller = Get.put(
      VideoTrimController(videoPath: videoPath),
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const _LoadingWidget();
        }

        return isLandscape
            ? _VideoTrimLandscapeView(controller: controller)
            : _VideoTrimPortraitView(controller: controller);
      }),
    );
  }
}

/// Portrait view for video trimming
class _VideoTrimPortraitView extends StatelessWidget {
  final VideoTrimController controller;

  const _VideoTrimPortraitView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video preview with trim timeline
        Positioned.fill(
          child: Column(children: [_buildVideoPreview(), _buildTrimTimeline()]),
        ),

        // Top controls
        _buildCloseButton(context),
        _buildDeleteButton(context),
        _buildTimeIndicator(context),

        // Save button
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildVideoPreview() {
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.editorController!.video.value.aspectRatio,
          child: CropGridViewer.preview(
            controller: controller.editorController!,
          ),
        ),
      ),
    );
  }

  Widget _buildTrimTimeline() {
    return ClipRect(
      child: SafeArea(
        child: Container(
          height: 96.h,
          color: AppColors.black.withValues(alpha: 0.8),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: TrimSlider(
            controller: controller.editorController!,
            height: 70.h,
            child: TrimTimeline(
              controller: controller.editorController!,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 20.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, color: AppColors.white, size: 24.sp),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      right: 20.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_outline,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeIndicator(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            controller.formatDuration(
              controller.editorController!.videoDuration,
            ),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned(
      bottom: 115.h,
      left: 0,
      right: 0,
      child: Center(
        child: Obx(
          () => controller.isProcessing.value
              ? Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.white,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.saveVideo(),
                  child: Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.upload_outlined,
                      color: AppColors.white,
                      size: 32.sp,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

/// Landscape view for video trimming
class _VideoTrimLandscapeView extends StatelessWidget {
  final VideoTrimController controller;

  const _VideoTrimLandscapeView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video preview with trim timeline
        Positioned.fill(
          child: Column(children: [_buildVideoPreview(), _buildTrimTimeline()]),
        ),

        // Top controls
        _buildCloseButton(context),
        _buildDeleteButton(context),
        _buildTimeIndicator(context),

        // Save button
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildVideoPreview() {
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.editorController!.video.value.aspectRatio,
          child: CropGridViewer.preview(
            controller: controller.editorController!,
          ),
        ),
      ),
    );
  }

  Widget _buildTrimTimeline() {
    return ClipRect(
      child: SafeArea(
        child: Container(
          height: 60.h,
          color: AppColors.black.withValues(alpha: 0.8),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
          child: TrimSlider(
            controller: controller.editorController!,
            height: 30.h,
            child: TrimTimeline(
              controller: controller.editorController!,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 10.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, color: AppColors.white, size: 12.sp),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 60.h,
      left: 10.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_outline,
            color: AppColors.white,
            size: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeIndicator(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            controller.formatDuration(
              controller.editorController!.videoDuration,
            ),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 7.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 10.w,
      child: Center(
        child: Obx(
          () => controller.isProcessing.value
              ? Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: AppColors.white,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.saveVideo(),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.pink.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.upload_outlined,
                      color: AppColors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

/// Loading widget shown while video is initializing
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.white),
    );
  }
}
