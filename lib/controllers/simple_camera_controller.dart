import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SimpleCameraController extends GetxController {
  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  RxBool isInitialized = false.obs;
  RxBool isRecording = false.obs;
  RxString recordingPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> initializeCamera() async {
    try {
      // Request permissions
      final cameraStatus = await Permission.camera.request();
      final microphoneStatus = await Permission.microphone.request();

      if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
        print('Permissions not granted');
        return;
      }

      // Get cameras
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        print('No cameras found');
        return;
      }

      print('Found ${cameras.length} cameras');

      // Initialize camera with the first available camera
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset
            .medium, // Use medium resolution for better compatibility
        enableAudio: true,
      );

      await cameraController!.initialize();
      print('Camera initialized successfully');

      isInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> startRecording() async {
    if (cameraController == null || !isInitialized.value) return;

    try {
      await cameraController!.startVideoRecording();
      isRecording.value = true;
      print('Recording started');
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (cameraController == null || !isRecording.value) return;

    try {
      final XFile videoFile = await cameraController!.stopVideoRecording();
      isRecording.value = false;
      recordingPath.value = videoFile.path;
      print('Recording stopped. Path: ${videoFile.path}');

      Get.snackbar(
        'Success',
        'Video saved to: ${videoFile.path}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }
}
