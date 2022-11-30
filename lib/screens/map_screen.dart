import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
          latitude: 25.276987, longitude: 55.296249, address: ''),
      this.isSelecting = true});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedLocation = LatLng(0, 0);

  void selectLocation(LatLng position) {
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  pickedLocation == null
                      ? null
                      : Navigator.of(context).pop(pickedLocation);
                },
                icon: Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(25.276987, 55.296249),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? selectLocation : null,
        markers: {
          Marker(
              markerId: MarkerId('m1'),
              position: pickedLocation ??
                  LatLng(widget.initialLocation.latitude,
                      widget.initialLocation.longitude)),
        },
      ),
    );
  }
}
