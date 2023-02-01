import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'apple_vision_flutter_platform_interface.dart';
import 'recognize_result.dart';

/// An implementation of [AppleVisionFlutterPlatform] that uses method channels.
class MethodChannelAppleVisionFlutter extends AppleVisionFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_vision_flutter');

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
