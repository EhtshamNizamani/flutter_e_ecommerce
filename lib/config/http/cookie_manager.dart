import 'package:universal_html/html.dart' as html;

class CookieManager {
  /// Insert or update a cookie
  static void insertCookie(String key, String value, {int? maxAgeDays}) {
    String cookie = '$key=$value; path=/';

    if (maxAgeDays != null) {
      final DateTime expiryDate =
          DateTime.now().add(Duration(days: maxAgeDays));
      cookie += '; expires=${expiryDate.toUtc().toIso8601String()}';
    }

    html.document.cookie = cookie;
  }

  /// Retrieve a cookie by key
  static String? retrieveCookie(String key) {
    final cookies = html.document.cookie?.split('; ') ?? [];
    for (var cookie in cookies) {
      final cookiePair = cookie.split('=');
      if (cookiePair[0] == key) {
        return cookiePair[1];
      }
    }
    return null;
  }

  /// Delete a cookie by setting its expiry date in the past
  static void deleteCookie(String key) {
    html.document.cookie =
        '$key=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
  }
}
