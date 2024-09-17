import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('accessToken');
  }

  Future<void> saveRefreshToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('saveRefreshToken');
  }

  Future<void> clearInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
