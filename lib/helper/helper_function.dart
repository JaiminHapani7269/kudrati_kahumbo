import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String logKey = "LOGKEY";

  static Future<bool> saveLogingData(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn);
  }

  static Future<bool?> getLoginData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(logKey);
  }
}
