// http get, put, post

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/http/token_manager.dart';
import 'package:flutter_e_commerce/feature/shared_widget/toast_message.dart';
import 'package:flutter_e_commerce/global/global.dart';
import 'package:flutter_e_commerce/service/shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class TokenInterceptor implements InterceptorContract {
  @override
  Future<http.BaseRequest> interceptRequest(
      {required http.BaseRequest request}) async {
    print("NEW TOKEN IS WORKING interceptRequest");
    await TokenManager.refreshTokenIfNeeded();
    final token = await TokenManager.getAccessToken();
    print("TOKEN ${token}");

    if (token != null) {
      // Update the headers
      request.headers['authorization'] = 'Bearer $token';

      if (request is http.Request) {
        final originalBody = request.body;
        request = http.Request(request.method, request.url)
          ..headers.addAll(request.headers)
          ..body = originalBody;
      }
    }

    return request;
  }

  @override
  Future<http.BaseResponse> interceptResponse(
      {required http.BaseResponse response}) async {
    try {
      print(
          "InterceptResponse is triggered with status code: ${response.statusCode}");
      if (response.statusCode == 419) {
        await TokenManager.clearTokens();
        // await SharedPreferencesManager().clearInformation();
        // navigatorKey.currentState?.pushReplacementNamed(signInScreenV2);
      }
      return response;
    } catch (e) {
      print("Error in interceptResponse: $e");
      rethrow; // Re-throw the error after logging it
    }
  }

  // Optional: If you don't need to intercept the request or response here,
  // you can safely remove or keep these methods with their default implementation.
  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    print("HELLO WOWRLD shouldInterceptResponse");
    return true;
  }
}

class HttpServices {
  final baseUrl = Global.apiUrl;
  Future<dynamic> get(
      {required String apiUrl,
      required Map<String, String> headers,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};
    if (query != null) {
      queryParams = query;
    }

    final tempUrl = baseUrl + apiUrl;
    print("TEMP URL ${tempUrl}");

    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);
    try {
      final client =
          InterceptedClient.build(interceptors: [TokenInterceptor()]);
      final Response response = await client.get(uri, headers: headers);
      print("TEMP status code ${response.statusCode}");

      if (kDebugMode) {
        print(response.statusCode);
      }

      if (response.statusCode == 419) {
        print("HELLO WORLD");
        client.close();

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200) {
        client.close();
        return json.decode(response.body);
      } else if (response.statusCode == 419) {
        client.close();
        await _handleTokenExpiry();
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData.toString();
        client.close();
        throw Exception(errorMessage);
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams = query;
    }

    final tempUrl = baseUrl + apiUrl;
    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);
    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);
    try {
      final response = await client.post(Uri.parse(uri.toString()),
          headers: headers, body: json.encode(body));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 419) {
        print("HELLO WORLD");

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('success');
        }
        final dynamic responseBody = json.decode(response.body);
        if (responseBody['success']) {
          client.close();
          return json.decode(response.body);
        } else {
          client.close();
          CustomToast.showCustomToast(
              message: responseBody['body']['message'],
              webColor: AppColors.webRed,
              backgroundColor: AppColors.red,
              textColor: AppColors.white);
          throw responseBody['body']['message'];
        }
      } else {
        try {
          Map<String, dynamic> responseData = json.decode(response.body);
          String errorMessage = responseData['message'];
          client.close();
          throw errorMessage;
        } catch (error) {
          rethrow;
        }
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String apiUrl,
    required Map<String, String> headers,
  }) async {
    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);

    try {
      final response =
          await client.delete(Uri.parse(baseUrl + apiUrl), headers: headers);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 419) {
        print("HELLO WORLD");

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('success');
        }
        client.close();
        return json.decode(response.body);
      } else if (response.statusCode == 419) {
        client.close();
        await _handleTokenExpiry();
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData.toString();
        client.close();
        throw Exception(errorMessage);
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required String apiUrl,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);

    try {
      final response = await client.put(Uri.parse(baseUrl + apiUrl),
          headers: headers, body: json.encode(body));

      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 419) {
        print("HELLO WORLD");

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200) {
        client.close();
        return json.decode(response.body);
      } else if (response.statusCode == 419) {
        client.close();
        await _handleTokenExpiry();
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData.toString();
        client.close();
        throw Exception(errorMessage);
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      Map<String, dynamic>? query}) async {
    Map<String, String>? queryParams;

    if (query != null) {
      queryParams =
          query.map((key, value) => MapEntry(key.toString(), value.toString()));
    }

    final tempUrl = baseUrl + apiUrl;

    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);
    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);
    try {
      final response = await client.patch(Uri.parse(uri.toString()),
          headers: headers, body: json.encode(body));

      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 419) {
        print("HELLO WORLD");

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200) {
        client.close();
        return json.decode(response.body);
      } else if (response.statusCode == 419) {
        client.close();
        await _handleTokenExpiry();
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData.toString();
        client.close();
        throw Exception(errorMessage);
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postReqWithoutInterceptor(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams = query;
    }

    final tempUrl = baseUrl + apiUrl;
    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);

    final response = await http.post(Uri.parse(uri.toString()),
        headers: headers, body: json.encode(body));

    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print('success');
      }
      final dynamic responseBody = json.decode(response.body);
      if (responseBody['success']) {
        return json.decode(response.body);
      } else {
        throw responseBody['message'];
      }
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData['message'];

      throw Exception(errorMessage);
    }
  }

  Future<dynamic> postUserData(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body}) async {
    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);
    try {
      final response = await client.post(Uri.parse(baseUrl + apiUrl),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 419) {
        print("HELLO WORLD");

        await _handleTokenExpiry();
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('success');
        }
        client.close();
        return json.decode(response.body);
      } else if (response.statusCode == 419) {
        await _handleTokenExpiry();
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage = responseData.toString();
        if (kDebugMode) {
          print(errorMessage);

          print(response.statusCode);
        }
        client.close();
        throw Exception(errorMessage);
      }
    } on TimeoutException {
      throw Exception('Slow  internet ');
    } on SocketException {
      throw Exception('No internet ');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getCheckIsSocialMediaConnected(
      {required String apiUrl,
      required Map<String, String> headers,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams = query;
    }

    final tempUrl = baseUrl + apiUrl;
    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);

    final client = InterceptedClient.build(interceptors: [TokenInterceptor()]);
    final response = await client.get(uri, headers: headers);
    if (kDebugMode) {
      print(response.statusCode);
    }
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      bool success = decodedResponse['success'];
      client.close();
      return success;
    } else if (response.statusCode == 419) {
      bool success = decodedResponse['success'];
      client.close();
      await _handleTokenExpiry();
      return false;
    } else {
      bool success = decodedResponse['success'];
      client.close();
      return success;
    }
  }

  static Future<Map<String, String>> getHeadersWithToken() async {
    // final accessToken = await SharedPreferencesManager().getAccessToken();
    final accessTok = await TokenManager.getAccessToken();

    final headers = {
      'authorization': 'Bearer $accessTok',
      'connection': 'keep-alive',
      'content-type': 'application/json',
      'date': 'Mon,12 Feb 2024 13:03:12 GMT',
      'server': 'nginx/1.24.0'
    };

    return headers;
  }

  static Future<Map<String, String>> getHeadersWithoutToken() async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Access-Control-Allow-Credentials': 'true',
    };

    return headers;
  }

  Future<void> _handleTokenExpiry() async {
    // Clear stored tokens
    await TokenManager.clearTokens();
    await SharedPreferencesManager().clearInformation();
    // navigatorKey.currentState?.pushReplacementNamed(signInScreenV2);
  }
}
