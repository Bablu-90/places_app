import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places_app/Getx/great_placescontroller.dart';

class ImageInput extends StatefulWidget {
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> takePicture() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await ImagePicker();
    await imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          _storedImage = File(value.path);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GreatPlacesController greatPlacesController = Get.find();
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No Image Taken', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              takePicture();
            },
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepOrange.shade200,
                backgroundColor: Colors.red,
                fixedSize: Size(90, 45),
                textStyle: TextStyle(fontSize: 16.0)),
            icon: Icon(Icons.camera_alt_rounded),
            label: Text('Take a Picture!.'),
          ),
        ),
      ],
    );
  }
}
