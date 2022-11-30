import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:places_app/widgets/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function(double?, double?) onSelectPlace;

  LocationInput({required this.onSelectPlace});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String previewImageUrl = '';

  void showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    showPreview(locData.latitude!, locData.longitude!);
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> selectOnMap() async {
    final selectedLocation = await Get.to(MapScreen(isSelecting: true),
        fullscreenDialog: true, transition: Transition.upToDown);
    if (selectedLocation == null) {
      return;
    }
    showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () {
                getCurrentUserLocation();
              },
              icon: Icon(Icons.location_on_outlined),
              label: Text('Current Location'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                selectOnMap();
              },
              icon: Icon(Icons.map_rounded),
              label: Text('Select on Map'),
            )
          ],
        )
      ],
    );
  }
}
