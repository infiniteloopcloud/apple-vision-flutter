# flutter_apple_vision

A Flutter plugin to recognize text on images with Apple Vision.

## Features

- Recognize text from image data

## Example

```dart
import 'dart:typed_data';

import 'package:flutter_apple_vision/flutter_apple_vision.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  final imageData = await loadAsset();
  final recognizeResult = await FlutterAppleVision().recognizeText(imageData);
  
  print('Recognize result: ${recognizeResult.observations.map((o) => o.textOptions.first).join('\n')}');
}

Future<Uint8List> loadAsset() async {
  return await rootBundle.load('assets/image_with_text.png')
      .then((value) => value.buffer.asUint8List());
}
```
