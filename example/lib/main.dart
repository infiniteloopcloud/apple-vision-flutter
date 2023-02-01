import 'package:flutter/material.dart';
import 'package:apple_vision_flutter_example/scanner_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScannerPage(),
    );
  }
}
