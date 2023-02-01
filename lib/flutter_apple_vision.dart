import 'dart:typed_data';

import 'flutter_apple_vision_platform_interface.dart';
import 'recognize_result.dart';

class FlutterAppleVision {
  /// Returns recognized texts with their boundaries
  /// To learn about boundaries check the documentation:
  /// https://developer.apple.com/documentation/vision/vnrecognizedtextobservation
  Future<RecognizeResult> recognizeText(Uint8List imageData) {
    return FlutterAppleVisionPlatform.instance.recognizeText(imageData);
  }
}
