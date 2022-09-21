import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String userLoggedInKey = "LOGGEDINKEY";

  static Future<bool> saveUserLoggedInStatus(bool isUerLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUerLoggedIn);
  }

  static Future<bool?> getUserLoggedInstatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}
