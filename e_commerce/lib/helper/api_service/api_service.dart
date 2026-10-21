import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/helper/exception_handling/app_exception.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // UNIVERSAL GET API
  Future<dynamic> getApi({required String url, String? token}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return returnJsonResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(errorMsg: e.toString());
    } on AppException {
      rethrow;
    } catch (e) {
      throw FetchDataException(errorMsg: e.toString());
    }
  }

  // UNIVERSAL POST API
  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? mBodyoarams,
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: mBodyoarams == null ? null : jsonEncode(mBodyoarams),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("====> Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      return returnJsonResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(errorMsg: e.toString());
    } catch (e) {
      throw FetchDataException(errorMsg: e.toString());
    }
  }

  // UNIVERSAL JSON RETURN RESPONSE
  dynamic returnJsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        return data;

      case 401:
        throw UnauthorizedException(errorMsg: response.body);

      case 400:
        throw BadRequestException(errorMsg: response.body);

      case 404:
        throw NotFoundException(errorMsg: response.body);

      case 500:
        throw ServerException(errorMsg: response.body);

      default:
        throw FetchDataException(
          errorMsg: "Status code: ${response.statusCode}",
        );
    }
  }
}
