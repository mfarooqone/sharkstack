import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_editor/video_editor.dart';

import '../controllers/video_trim_controller.dart';
import '../utils/app_colors.dart';

/// Video Trimming Screen
///
/// Allows users to trim the recorded video before saving
class VideoTrimScreen extends StatelessWidget {
  final String videoPath;

  const VideoTrimScreen({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    final VideoTrimController controller = Get.put(
      VideoTrimController(videoPath: videoPath),
    );

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        }

        return Stack(
          children: [
            // Video preview with trim slider
            Positioned.fill(
              child: Column(
                children: [
                  // Video preview
                  Expanded(
                    child: Stack(
                      children: [
                        // Video player preview
                        Center(
                          child: AspectRatio(
                            aspectRatio: controller
                                .editorController!
                                .video
                                .value
                                .aspectRatio,
                            child: CropGridViewer.preview(
                              controller: controller.editorController!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Trimming timeline at bottom
                  ClipRect(
                    child: SafeArea(
                      child: Container(
                        height: 96.h,
                        color: AppColors.black.withValues(alpha: 0.8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 5.h,
                        ),
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
                  ),
                ],
              ),
            ),

            // Close button
            Positioned(
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
            ),

            // Delete button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  // Delete functionality
                  Get.back();
                },
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
            ),

            // Recording time indicator at top center
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
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
            ),

            // Save button
            Positioned(
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
            ),
          ],
        );
      }),
    );
  }
}
