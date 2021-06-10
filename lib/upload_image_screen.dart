import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:measurement_app/firebase_api.dart';
import 'package:measurement_app/show_measurement.dart';
import 'package:path/path.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? imageFile;
  UploadTask? task;

  Future<void> _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  Future uploadFile() async {
    if (imageFile == null) return;

    final fileName = basename(imageFile!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, imageFile!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
    // print('Download-Link: $urlDownload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _openCamera(context);
              final url = await uploadFile();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShowMeasurement(url: url);
                  },
                ),
              );
            },
            child: Text('Upload Image'),
          ),
        ),
      ),
    );
  }
}
