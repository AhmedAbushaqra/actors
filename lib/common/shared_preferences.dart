import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
Future<void> saveKeyAndStringValueToSharedPreferences(String key, String value) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(key, value);
}

Future<String> getKeyAndStringValueFromSharedPreferences(String key) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key) ?? '';
}

Future<void> saveNameToSharedPreferences(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
}

Future<String> getNameFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name') ?? '';
}

