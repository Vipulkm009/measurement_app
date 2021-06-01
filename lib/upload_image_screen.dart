import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:measurement_app/show_measurement.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  PickedFile? imageFile;

  Future<void> _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _openCamera(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShowMeasurement(imageFile: imageFile);
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
