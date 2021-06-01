import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowMeasurement extends StatefulWidget {
  PickedFile? imageFile;

  ShowMeasurement({required this.imageFile});

  @override
  _ShowMeasurementState createState() => _ShowMeasurementState();
}

class _ShowMeasurementState extends State<ShowMeasurement> {
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(widget.imageFile!.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget.imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Image.file(File(widget.imageFile!.path)),
        ),
      ),
    );
  }
}
