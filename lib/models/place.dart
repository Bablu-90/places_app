import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.address,
    required this.longitude,
  });
}

class Place {
  final String id;
  final String title;
  PlaceLocation location;

  final File image;

  Place({
    required this.id,
    required this.title,
    required this.image,
    this.location = const PlaceLocation(
        latitude: 25.276987, address: 'Zayed Road', longitude: 55.296249),
    /* required this.location,*/
  });
}
