import 'dart:typed_data';

import 'apple_vision_flutter_platform_interface.dart';
import 'recognize_result.dart';

class AppleVisionFlutter {
  /// Returns recognized texts with their boundaries
  /// To learn about boundaries check the documentation:
  /// https://developer.apple.com/documentation/vision/vnrecognizedtextobservation
  Future<RecognizeResult> recognizeText(Uint8List imageData) {
    return AppleVisionFlutterPlatform.instance.recognizeText(imageData);
  }
}
