import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places_app/shared_preferences/place_preferences.dart';
import 'package:places_app/widgets/location_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/place.dart';

class GreatPlacesController extends GetxController {
  RxList<Place> items = <Place>[].obs;
  final titleController = TextEditingController();
  File? pickedImage;
  PlaceLocation? pickedLocation;

  Place findById(String id) {
    return items.firstWhere((place) => place.id == id);
  }

  void selectImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera).then((pickedPhoto) {
      if (pickedPhoto != null) {
        pickedImage = File(pickedPhoto.path);
      }
    });
  }

  void selectPlace(double lat, double lng) {
    pickedLocation = PlaceLocation(latitude: lat, address: '', longitude: lng);
  }

  void savePlace() {
    /*if (titleController.text.isEmpty || pickedImage == null) || pickedLocation==null{
      return;
    }*/
    GreatPlacesController greatPlacesController =
        Get.put(GreatPlacesController());
    greatPlacesController.addPlace(
        titleController.text, pickedImage!, pickedLocation!);
    Get.back();
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        address: address,
        longitude: pickedLocation.longitude);
    print("Item Count: ${items.length}");
    Place newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
      /*location: ,*/
    );
    items.add(newPlace);
    print("Item Count: ${items.length}");
    await PlacePreferences.savePlace(<String>['Delhi', 'Mumbai', 'Bangalore']);
  }

  Future<void> fetchPlace() async {
    await SharedPreferences.getInstance().then((prefs) {
      return prefs.getStringList('place')!;
    });
  }

/* RxList<Place> get items {
    return [...?_items].obs;
  }*/
}
