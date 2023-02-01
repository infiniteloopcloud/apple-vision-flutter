import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'apple_vision_flutter_method_channel.dart';
import 'recognize_result.dart';

abstract class AppleVisionFlutterPlatform extends PlatformInterface {
  /// Constructs a AppleVisionFlutterPlatform.
  AppleVisionFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppleVisionFlutterPlatform _instance =
      MethodChannelAppleVisionFlutter();

  /// The default instance of [AppleVisionFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppleVisionFlutter].
  static AppleVisionFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppleVisionFlutterPlatform] when
  /// they register themselves.
  static set instance(AppleVisionFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<RecognizeResult> recognizeText(Uint8List imageData) {
    throw UnimplementedError('recognizeText() has not been implemented.');
  }
}
