import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:places_app/shared_preferences/place_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([]);

  await PlacePreferences.savePlace(<String>['Delhi', 'Mumbai', 'kerala']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Great Places',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.amberAccent,
      ),
      home: PlacesListScreen(),
    );
  }
}
