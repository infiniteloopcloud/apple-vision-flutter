import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_apple_vision_method_channel.dart';
import 'recognize_result.dart';

abstract class FlutterAppleVisionPlatform extends PlatformInterface {
  /// Constructs a FlutterAppleVisionPlatform.
  FlutterAppleVisionPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppleVisionPlatform _instance =
      MethodChannelFlutterAppleVision();

  /// The default instance of [FlutterAppleVisionPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppleVision].
  static FlutterAppleVisionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppleVisionPlatform] when
  /// they register themselves.
  static set instance(FlutterAppleVisionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<RecognizeResult> recognizeText(Uint8List imageData) {
    throw UnimplementedError('recognizeText() has not been implemented.');
  }
}
