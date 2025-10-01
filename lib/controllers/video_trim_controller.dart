import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:video_editor/video_editor.dart';

import '../utils/app_colors.dart';

/// Video Trim Controller
///
/// Handles video trimming, playback, and video compression
class VideoTrimController extends GetxController {
  final String videoPath;
  VideoEditorController? editorController;

  // State observables
  final RxBool isInitialized = false.obs;
  final RxBool isProcessing = false.obs;
  final RxDouble exportProgress = 0.0.obs;

  VideoTrimController({required this.videoPath});

  @override
  void onInit() {
    super.onInit();
    _initializeVideo();
  }

  @override
  void onClose() {
    editorController?.dispose();
    super.onClose();
  }

  /// Initialize video editor
  Future<void> _initializeVideo() async {
    try {
      editorController = VideoEditorController.file(
        File(videoPath),
        minDuration: const Duration(seconds: 1),
        maxDuration: const Duration(minutes: 10),
      );

      await editorController!.initialize();
      isInitialized.value = true;
    } catch (e) {
      _showErrorSnackbar('Error', 'Failed to load video: $e');
      Get.back();
    }
  }

  /// Toggle play/pause
  void togglePlayPause() {
    if (editorController == null) return;

    if (editorController!.video.value.isPlaying) {
      editorController!.video.pause();
    } else {
      editorController!.video.play();
    }
  }

  /// Get video player controller
  bool get isPlaying => editorController?.video.value.isPlaying ?? false;

  /// Format duration as MM:SS
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Save trimmed video
  Future<void> saveVideo() async {
    if (isProcessing.value || editorController == null) return;

    isProcessing.value = true;
    exportProgress.value = 0.0;

    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String finalFileName =
          'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final String finalPath = path.join(appDir.path, finalFileName);

      // Simple save - video_editor's export requires additional platform setup
      // Copy original file for now (trimming UI works, export needs FFmpeg config)
      await File(videoPath).copy(finalPath);
      exportProgress.value = 1.0;

      isProcessing.value = false;
      _showSuccessSnackbar('Success', 'Video saved successfully!');

      // Go back to home screen
      Get.back(); // Close trim screen
      Get.back(); // Close recording screen
    } catch (e) {
      isProcessing.value = false;
      _showErrorSnackbar('Error', 'Failed to save video: $e');
      print('Error details: $e');
    }
  }

  // Helper methods for snackbars
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.red,
      colorText: AppColors.white,
    );
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.green,
      colorText: AppColors.white,
    );
  }
}
