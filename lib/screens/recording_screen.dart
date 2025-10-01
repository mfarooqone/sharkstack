import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_shark_stack/widgets/camera_bottom_controls.dart';
import 'package:task_shark_stack/widgets/camera_zoom_controls.dart';

import '../controllers/camera_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_labels.dart';
import '../utils/app_text_styles.dart';
import '../widgets/camera_top_bar.dart';

/// Recording Screen
///
/// Main camera recording interface with full-screen camera preview,
/// zoom controls, settings, and recording functionality.
class RecordingScreen extends StatelessWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final CameraRecordingController controller = Get.put(
      CameraRecordingController(),
    );

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const _LoadingWidget();
        }

        return Stack(
          children: [
            // Camera Preview - Full Screen
            Positioned.fill(child: CameraPreview(controller.cameraController!)),

            // Top bar with close button and upload indicator
            isLandscape
                ? CameraTopBarLandscape(controller: controller)
                : CameraTopBar(controller: controller),

            // Zoom controls in the middle
            isLandscape
                ? CameraZoomControlsLandscape(controller: controller)
                : CameraZoomControls(controller: controller),

            // Bottom controls with settings and record button
            isLandscape
                ? CameraBottomControlsLandscape(controller: controller)
                : CameraBottomControls(controller: controller),

            // Bottom action bar with upload, save toggle, and live button
            // CameraActionBar(controller: controller),

            // Recording indicator (only shown when recording)
            // if (controller.isRecording.value)
            //   CameraRecordingIndicator(controller: controller),

            // Settings bottom sheet (only shown when settings are open)
            // if (controller.showSettingsSheet.value)
            //   CameraSettingsSheet(controller: controller),
          ],
        );
      }),
    );
  }
}

/// Loading widget shown while camera is initializing
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.white),
          const SizedBox(height: 20),
          Text(
            AppLabels.initializingCamera,
            style: AppTextStyle.titleMedium.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
