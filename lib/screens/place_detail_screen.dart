import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:places_app/Getx/great_placescontroller.dart';
import 'package:places_app/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({Key? key}) : super(key: key);
  GreatPlacesController greatPlacesController =
      Get.put(GreatPlacesController());

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments.toString();
    final selectedPlace = greatPlacesController.findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 250,
              width: double.infinity,
              child: Image.file(selectedPlace.image,
                  fit: BoxFit.cover, width: double.infinity)),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              Get.to(
                  MapScreen(
                      initialLocation: selectedPlace.location,
                      isSelecting: false),
                  transition: Transition.circularReveal,
                  fullscreenDialog: true);
            },
            child: Text(
              'View on Map',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
