import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/http/http_services.dart';
import 'package:flutter_e_commerce/config/http/token_manager.dart';
import 'package:flutter_e_commerce/config/model/user/api_response.dart';
import 'package:flutter_e_commerce/config/model/user/user_model.dart';
import 'package:flutter_e_commerce/feature/shared_widget/toast_message.dart';
import 'package:flutter_e_commerce/global/global.dart';
import 'package:flutter_e_commerce/model/login_response.dart';
import 'package:flutter_e_commerce/model/refresh_token_response.dart';
import 'package:flutter_e_commerce/service/shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class AuthService {
  static Future<UserModel> registerUser(
      String name, String email, String password) async {
    const apiUrl = 'users/register';
    final Map<String, String> headers =
        await HttpServices.getHeadersWithoutToken();
    try {
      apiUrl;
      final response = await HttpServices()
          .postReqWithoutInterceptor(apiUrl: apiUrl, headers: headers, body: {
        "name": name,
        "email": email,
        "password": password,
      });
      await AuthService.checkCookies();
      final apiResponse = ApiResponse.fromJson(response);
      await SharedPreferencesManager()
          .saveAccessToken(apiResponse.data.accessToken);
      await SharedPreferencesManager()
          .saveRefreshToken(apiResponse.data.refreshToken);

      return apiResponse.data;
    } catch (e) {
      print('test$e');
      rethrow;
    }
  }

  static Future<UserModel> loginUser(String email, String password) async {
    const apiUrl = 'users/login';
    final Map<String, String> headers =
        await HttpServices.getHeadersWithoutToken();
    try {
      apiUrl;
      final response = await HttpServices()
          .postReqWithoutInterceptor(apiUrl: apiUrl, headers: headers, body: {
        "email": email,
        "password": password,
      });
      print("response $response");
      await AuthService.checkCookies();
      final apiResponse = ApiResponse.fromJson(response);
      await SharedPreferencesManager()
          .saveAccessToken(apiResponse.data.accessToken);
      await SharedPreferencesManager()
          .saveRefreshToken(apiResponse.data.refreshToken);

      return apiResponse.data;
    } catch (e) {
      print('test$e');
      rethrow;
    }
  }

  static Future<RefreshTokenResponse> refreshToken(String token) async {
    const apiUrl = 'api/client/auth/refresh-token';
    final Map<String, String> headers =
        await HttpServices.getHeadersWithoutToken();
    try {
      final tempUrl = Global.apiUrl + apiUrl;
      Uri uri = Uri.parse(tempUrl);
      print("refreshToken ${tempUrl}");

      final response = await http.post(Uri.parse(uri.toString()), headers: {
        'access-control-allow-credentials': 'true',
        'access-control-allow-origin': '*',
        'connection': 'keep-alive',
        'server': 'nginx/1.24.0',
      }, body: {
        "refreshToken": token
      });
      print("refreshTokens ${response.body}");
      print("STATIS CODE  ${response.statusCode}");

      final dynamic responseBody = json.decode(response.body);
      if (responseBody["body"]["statusCode"] == 419) {
        print("HELLO WORLD");

        await TokenManager.clearTokens();
        await SharedPreferencesManager().clearInformation();
        // navigatorKey.currentState?.pushReplacementNamed(signInScreenV2);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('success');
        }
        if (responseBody['success']) {
          print("resospoee ${responseBody.toString()}");
          final RefreshTokenResponse refreshTokenResponse =
              RefreshTokenResponse.fromJson(responseBody);
          return refreshTokenResponse;
        } else {
          CustomToast.showCustomToast(
              message: responseBody['body']['message'],
              webColor: AppColors.webRed,
              backgroundColor: AppColors.red,
              textColor: AppColors.white);
          throw responseBody['body']['message'];
        }
      } else if (response.statusCode == 419) {
        print("HELLO WORLD");
        await TokenManager.clearTokens();
        await SharedPreferencesManager().clearInformation();
        // navigatorKey.currentState?.pushReplacementNamed(signInScreenV2);
        throw "Token has Expired";
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData['message'];
        throw errorMessage;
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      print('test$e');
      rethrow;
    }
  }

  static Future<void> checkCookies() async {
    // Retrieve access token from cookies
    String? accessToken = getCookie('accessToken');
    String? refreshToken = getCookie('refreshToken');

    if (accessToken != null) {
      print('Access Token: $accessToken');
    } else {
      print('No access token found');
    }

    if (refreshToken != null) {
      print('Refresh Token: $refreshToken');
    } else {
      print('No refresh token found');
    }
  }

  static String? getCookie(String name) {
    print("cookies${html.document.toString()}");

    final cookies = html.document.cookie?.split('; ') ?? [];
    for (var cookie in cookies) {
      final cookiePair = cookie.split('=');

      if (cookiePair[0] == name) {
        return cookiePair[1];
      }
    }
    return null;
  }
}
