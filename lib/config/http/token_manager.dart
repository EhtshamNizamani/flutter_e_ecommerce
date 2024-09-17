import 'package:flutter_e_commerce/service/auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final _storage = FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _expiryTimeKey = 'expiry_time';

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<void> saveAccessToken(accessToken) async {
    return await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<void> setTokens(
      String accessToken, String refreshToken, DateTime expiryTime) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(
        key: _expiryTimeKey, value: expiryTime.toIso8601String());
  }

  static Future<void> refreshTokenIfNeeded() async {
    final expiryTimeString = await _storage.read(key: _expiryTimeKey);

    if (expiryTimeString != null) {
      DateTime expiryTime = DateTime.parse(expiryTimeString);
      final currentTime = DateTime.now();
      final timeUntilExpiry = expiryTime.difference(currentTime);
      print("RESPONSE is here ");

      if (timeUntilExpiry <= Duration(seconds: 0)) {
        final refreshToken = await _storage.read(key: _refreshTokenKey);
        print("RESPONSE is here 2");

        if (refreshToken != null) {
          print("RESPONSE is here 3");

          final response = await AuthService.refreshToken(refreshToken);
          print("RESPONSE is here ${response}");

          if (response != null && response.body.token.accessToken != null) {
            print("RESPONSE is here ");
            final newExpiryTime = DateTime.now().add(
              Duration(minutes: 4, seconds: 30),
            );
            // await SharedPreferencesManager()
            //     .saveChatToken(response.body.token.chatToken);

            await setTokens(
              response.body.token.accessToken,
              refreshToken,
              newExpiryTime,
            );
            print("update new time ${newExpiryTime} ");
          } else {
            throw Exception('Failed to refresh token');
          }
        }
      }
    }
  }

  static Future<bool> refreshTokenNeededOrNot() async {
    final expiryTimeString = await _storage.read(key: _expiryTimeKey);
    if (expiryTimeString != null) {
      final expiryTime = DateTime.parse(expiryTimeString);
      final currentTime = DateTime.now();
      if (expiryTime.isBefore(currentTime)) {
        final refreshToken = await _storage.read(key: _refreshTokenKey);
        if (refreshToken != null) {
          print("NEED TOKEN ");
          return true;
        }
      }
    }
    print("No NEED TOKEN ");

    return false;
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _expiryTimeKey);
  }
}
