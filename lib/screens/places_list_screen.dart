import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_detail_screen.dart';

import '../Getx/great_placescontroller.dart';

class PlacesListScreen extends StatelessWidget {
  PlacesListScreen({Key? key}) : super(key: key);

  GreatPlacesController greatPlacesController =
      Get.put(GreatPlacesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              color: Colors.red,
              onPressed: () {
                Get.to(() => AddPlaceScreen(),
                    transition: Transition.leftToRightWithFade);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Obx(
          () {
            return greatPlacesController.items.isEmpty
                ? Center(child: Text('Got no Places yet, start adding some!'))
                /*'{greatPlacesController.items
        .map((element) => element.id)
        .toList()
        .reduce((value, element) => value + element)
        .toString()}'*/
                : ListView.builder(
                    itemCount: greatPlacesController.items.length,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(
                          backgroundImage: FileImage(
                        greatPlacesController.items[i].image,
                      )),
                      title: Text(greatPlacesController.items[i].title),
                      subtitle:
                          Text(greatPlacesController.items[i].location.address),
                      onTap: () {
                        Get.to(PlaceDetailScreen(),
                            arguments: greatPlacesController.items[i].id,
                            transition: Transition.rightToLeft);
                      },
                    ),
                  );
          },
        ));
  }
}
