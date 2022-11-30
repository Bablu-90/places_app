import 'package:shared_preferences/shared_preferences.dart';

class PlacePreferences {
  static Future<void> savePlace(List<String> place) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('place', place);
    });
  }

  //getplace
  static Future<List<String>> getPlace() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getStringList('place')!;
    });
  }
}
