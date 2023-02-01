import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apple_vision/flutter_apple_vision.dart';
import 'package:flutter_apple_vision/recognize_result.dart';
import 'package:image/image.dart' as img;

class ScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _flutterAppleVisionPlugin = FlutterAppleVision();

  CameraController? _controller;
  XFile? imageFile;
  XFile? videoFile;

  VoidCallback? videoPlayerListener;

  RecognizeResult? _recognizeResult;

  double imageWidth = 1280;
  double imageHeight = 720;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: Stack(
              children: [
                if (_controller?.value.isInitialized == true)
                  Center(
                      child: AspectRatio(
                    aspectRatio: imageWidth / imageHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: _buildCameraPreview(),
                    ),
                  )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      color: Colors.black87,
                      child: Text(
                        _recognizeResult?.print() ?? '',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ])));
  }

  void initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      onNewCameraSelected((await availableCameras()).first);
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    await _controller?.dispose();

    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.unknown,
    );

    // If the _controller is updated then update the UI.
    _controller!.addListener(() {
      if (mounted) setState(() {});
      if (_controller!.value.hasError) {
        showInSnackBar('Camera error ${_controller!.value.errorDescription}');
      }
    });

    try {
      await _controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      _controller?.startImageStream((image) async {
        if (image.planes.isNotEmpty) {
          if (!_recognizing) {
            _recognizing = true;
            final imagePlane = image.planes.first;

            if (imagePlane.bytes.isNotEmpty) {
              var imageWidth = imagePlane.bytesPerRow ~/ 4;
              var imageHeight = imagePlane.height ?? 0;

              img.Image i = img.Image.fromBytes(
                width: imageWidth,
                height: imageHeight,
                bytes: imagePlane.bytes.buffer,
                order: img.ChannelOrder.bgra,
                numChannels: 4,
              );

              final imageData = img.encodeJpg(i);
              final recognizeResult =
                  await _flutterAppleVisionPlugin.recognizeText(imageData);

              setState(() {
                this.imageWidth = imageWidth.toDouble();
                this.imageHeight = imageHeight.toDouble();

                _recognizeResult = recognizeResult;
              });

              await Future.delayed(const Duration(milliseconds: 500));
            }

            _recognizing = false;
          }
        }
      });

      setState(() {});
    }
  }

  bool _recognizing = false;

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description ?? '');
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  _buildCameraPreview() {
    return _controller?.buildPreview();
  }
}

extension RecognizeResultToString on RecognizeResult {
  String print() => observations.map((e) => e.textOptions.first).join('\n');
}
