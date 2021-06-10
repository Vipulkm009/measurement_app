import 'dart:convert';
import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ShowMeasurement extends StatefulWidget {
  String url;

  ShowMeasurement({required this.url});

  @override
  _ShowMeasurementState createState() => _ShowMeasurementState();
}

class _ShowMeasurementState extends State<ShowMeasurement> {
  // @override
  // void initState() {}
  var data;

  void getData() async {
    http.Response response = await http.post(
      Uri.parse(
          'https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'imageURL': widget.url,
      }),
    );
    print(response.body);
    data = jsonDecode(response.body)[0];
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(
            data.toString(),
          ),
        ),
      ),
    );
  }
}
