import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_colors.dart';
import '../utils/app_labels.dart';

/// Camera Recording Controller
///
/// Manages camera initialization, video recording, zoom controls, and settings.
/// Uses GetX for state management with reactive UI updates.
class CameraRecordingController extends GetxController {
  // Private camera controller instance
  CameraController? _cameraController;

  // Camera properties
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;

  // Recording state observables
  final RxBool isRecording = false.obs;
  final RxBool isInitialized = false.obs;
  final RxBool isPaused = false.obs;
  final RxString recordingPath = ''.obs;
  final Rx<Duration> recordingDuration = Duration.zero.obs;

  // Zoom functionality
  final RxDouble currentZoom = 1.0.obs;
  final RxDouble maxZoom = 8.0.obs;
  final RxDouble minZoom = 1.0.obs;

  // Settings observables
  final RxBool showSettingsSheet = false.obs;
  final RxBool oneHandedMode = true.obs;
  final RxBool autoSaveToDevice = false.obs;
  final RxBool preserveSettings = false.obs;
  final RxString selectedLens = '24mm'.obs;

  // Action bar observables
  final RxBool saveToDevice = true.obs;
  final RxBool isLiveStreaming = false.obs;
  final RxInt uploadCount = 0.obs;

  // Timer for recording duration
  Timer? _recordingTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  @override
  void onClose() {
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    super.onClose();
  }

  /// Initialize camera with permissions and setup
  Future<void> _initializeCamera() async {
    try {
      // Request required permissions
      if (!await _requestPermissions()) return;

      // Get available cameras
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        _showErrorSnackbar(AppLabels.noCamera, AppLabels.noCamerasFound);
        return;
      }

      // Initialize camera controller
      await _initializeCameraController();
    } catch (e) {
      _showErrorSnackbar(
        AppLabels.cameraError,
        '${AppLabels.failedToInitializeCamera} $e',
      );
    }
  }

  /// Request camera and microphone permissions
  Future<bool> _requestPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    if (!cameraPermission.isGranted || !microphonePermission.isGranted) {
      _showErrorSnackbar(
        AppLabels.permissionRequired,
        AppLabels.cameraMicrophoneRequired,
      );
      return false;
    }
    return true;
  }

  /// Initialize camera controller with medium resolution for compatibility
  Future<void> _initializeCameraController() async {
    try {
      _cameraController = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.medium, // Medium resolution for better compatibility
        enableAudio: true,
      );

      await _cameraController!.initialize();

      // Get zoom capabilities
      maxZoom.value = await _cameraController!.getMaxZoomLevel();
      minZoom.value = await _cameraController!.getMinZoomLevel();

      isInitialized.value = true;
      update(); // Force UI update
    } catch (e) {
      await _initializeWithFallback();
    }
  }

  /// Fallback initialization with lower quality settings
  Future<void> _initializeWithFallback() async {
    try {
      _cameraController = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.medium,
        enableAudio: true,
        imageFormatGroup: Platform.isIOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.yuv420,
      );

      await _cameraController!.initialize();
      isInitialized.value = true;

      _showWarningSnackbar(
        AppLabels.qualityAdjusted,
        AppLabels.qualityAdjustedDesc,
      );
    } catch (e) {
      _showErrorSnackbar(
        AppLabels.cameraError,
        'Failed to initialize camera with any quality setting.',
      );
    }
  }

  /// Start video recording with current orientation
  Future<void> startRecording({required bool isLandscape}) async {
    if (!isInitialized.value || _cameraController == null) return;

    try {
      // Lock orientation to current orientation only when recording starts
      // This prevents any rotation during recording
      // Note: We allow both landscape orientations to prevent forced rotation
      await SystemChrome.setPreferredOrientations(
        isLandscape
            ? [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]
            : [DeviceOrientation.portraitUp],
      );

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName =
          'recording_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final String filePath = path.join(appDir.path, fileName);

      await _cameraController!.startVideoRecording();

      isRecording.value = true;
      recordingPath.value = filePath;
      recordingDuration.value = Duration.zero;

      // Start recording timer
      _startRecordingTimer();
    } catch (e) {
      _showErrorSnackbar(
        AppLabels.recordingError,
        '${AppLabels.failedToStartRecording} $e',
      );
    }
  }

  /// Stop video recording
  Future<void> stopRecording() async {
    if (!isRecording.value || _cameraController == null) return;

    try {
      final XFile videoFile = await _cameraController!.stopVideoRecording();

      isRecording.value = false;
      _recordingTimer?.cancel();

      // Unlock orientation when recording stops
      await SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      // Save video file
      await videoFile.saveTo(recordingPath.value);

      _showSuccessSnackbar(
        AppLabels.recordingComplete,
        AppLabels.videoSavedSuccessfully,
      );
      Get.back(); // Return to home screen
    } catch (e) {
      _showErrorSnackbar(
        AppLabels.recordingError,
        '${AppLabels.failedToStopRecording} $e',
      );
    }
  }

  /// Start recording duration timer
  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordingDuration.value = Duration(seconds: timer.tick);
    });
  }

  /// Switch between front and back camera
  Future<void> switchCamera() async {
    if (cameras.length <= 1) return;

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await _initializeCameraController();
  }

  /// Set zoom level
  Future<void> setZoom(double zoom) async {
    if (_cameraController == null || !isInitialized.value) return;

    try {
      final clampedZoom = zoom.clamp(minZoom.value, maxZoom.value);
      await _cameraController!.setZoomLevel(clampedZoom);
      currentZoom.value = clampedZoom;
    } catch (e) {
      print('Error setting zoom: $e');
    }
  }

  /// Zoom in by 1x
  Future<void> zoomIn() async {
    final newZoom = (currentZoom.value + 1.0).clamp(
      minZoom.value,
      maxZoom.value,
    );
    await setZoom(newZoom);
  }

  /// Zoom out by 1x
  Future<void> zoomOut() async {
    final newZoom = (currentZoom.value - 1.0).clamp(
      minZoom.value,
      maxZoom.value,
    );
    await setZoom(newZoom);
  }

  /// Set zoom to specific level
  Future<void> setZoomToLevel(double level) async {
    await setZoom(level);
  }

  /// Toggle settings sheet visibility
  void toggleSettingsSheet() {
    showSettingsSheet.value = !showSettingsSheet.value;
  }

  /// Set selected camera lens
  void setSelectedLens(String lens) {
    selectedLens.value = lens;
  }

  /// Toggle save to device setting
  void toggleSaveToDevice() {
    saveToDevice.value = !saveToDevice.value;
  }

  /// Toggle live streaming
  void toggleLiveStreaming() {
    isLiveStreaming.value = !isLiveStreaming.value;
  }

  /// Upload media functionality
  void uploadMedia() {
    uploadCount.value++;
    // Here you would implement actual upload logic
    print('Uploading media... Upload count: ${uploadCount.value}');
  }

  /// Format duration as MM:SS
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Get camera controller instance
  CameraController? get cameraController => _cameraController;

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

  void _showWarningSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.orange,
      colorText: AppColors.white,
    );
  }
}
