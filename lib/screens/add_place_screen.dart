import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:places_app/Getx/great_placescontroller.dart';
import 'package:places_app/shared_preferences/place_preferences.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    GreatPlacesController greatPlacesController =
        Get.put(GreatPlacesController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        centerTitle: true,
        title: Text('Add a New Place'),
      ),
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: greatPlacesController.titleController,
                  ),
                  SizedBox(height: 10),
                  ImageInput(),
                  SizedBox(height: 10),
                  LocationInput(
                    onSelectPlace: (lat, lng) {},
                  ),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: () async {
              print("Add Place Clicked");
              greatPlacesController.savePlace();
              await PlacePreferences.savePlace(<String>['place']);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            icon: Icon(Icons.add),
            label: Text('Add Place'),
          ),
        ],
      ),
    );
  }
}
