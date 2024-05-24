import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
Future<void> saveKeyAndListValueToSharedPreferences(String key, List<String> value) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setStringList(key, value);
}

Future<List<String>> getKeyAndListValueFromSharedPreferences(String key) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getStringList(key) ?? [''];
}

