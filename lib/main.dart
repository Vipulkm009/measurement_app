import 'package:flutter/material.dart';
import 'package:measurement_app/upload_image_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measurement App',
      home: UploadImageScreen(),
    );
  }
}
