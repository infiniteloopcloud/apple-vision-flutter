import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_apple_vision_platform_interface.dart';
import 'recognize_result.dart';

/// An implementation of [FlutterAppleVisionPlatform] that uses method channels.
class MethodChannelFlutterAppleVision extends FlutterAppleVisionPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_apple_vision');

  @override
  Future<RecognizeResult> recognizeText(Uint8List imageData) =>
      methodChannel.invokeMethod('recognizeText', imageData).then((value) {
        List<Observation>? list;

        if (value is List) {
          list = value.map((e) {
            final map = e as Map;

            return Observation(
                (map['rect'] as List)
                    .map((e) => (e as num).toDouble())
                    .toList(),
                (map['textOptions'] as List).map((e) => e as String).toList());
          }).toList();
        }

        return RecognizeResult(list ?? []);
      });
}
