import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:joistic_job_portal/Singleton/singleton.dart';
import 'package:joistic_job_portal/constants/app_constants.dart';
import 'package:joistic_job_portal/network/response_method/response.dart';

class ApiClient {
  Future<Response<T>> post<T>(String endpoint, T Function(dynamic) fromJson,
      {Object? body,
      Map<String, String>? headers,
      bool isLogin = false}) async {
    log("body=> $body");

    try {
      hideKeyboard();
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      log("url=> $endpoint");
      log("headers => $headers");
      log("response status code=> ${response.statusCode}");
      log("response log=> ${response.body}");
      log("response log=> $response");

      switch (json.decode(response.body)["statusCode"]) {
        case 200:
          return Response.success(
              (json.decode(response.body)));
        case 401:
          if (!isLogin) {
            // Singleton.instance.accessToken = null;
            Singleton.instance.clearPref();
            // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.teacherLogin);
          }
          // Singleton.instance.isUnAuthorized = true;
          //  if (Singleton.instance.isUnAuthorized = true) {
          //
          //  }

          return Response.failure(
              json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 404:
          Singleton.instance.clearPref();
          if (!isLogin) {
            // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.teacherLogin);
          }
          return Response.failure(
              json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 400:
          log('error 400');
          return Response.failure(
              json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 500:
          return Response.failure(
              json.decode(response.body)["message"] ?? "Something Went Wrong");

        case 429:
          return Response.failure("Something Went Wrong");
        default:
          return Response.failure(
              json.decode(response.body)["message"] ?? "Something Went Wrong",
              responseCode: response.statusCode);
      }
    } catch (e) {
      log('API FAILED');
      return Response.failure('An error occurred in response catch: $e');
    }
  }

  Future<Response<T>> get<T>(
    String endpoint,
    T Function(dynamic) fromJson, {
    Map<String, String>? parameters,
    Map<String, String>? headers,
  }) async {
    hideKeyboard();
    final response = await http.get(
      Uri.parse(endpoint),
      headers: headers,
    );

    log("url=> $endpoint");
    log("headers => ${headers}");
    log("response status code=> ${response.statusCode}");
    log("response log=> ${response.body}");

    switch (response.statusCode) {
      case 200:
        return Response.success(fromJson(json.decode(response.body)));
      case 401:
        // if (Singleton.instance.loginUserType == 0) {
        //   Singleton.instance.setCrateLogin(false);
        //   Singleton.instance.clearPrefCrate();
        //   locationService?.stopService();
        // } else {
        //   Singleton.instance.setReelLogin(false);
        //   Singleton.instance.clearPrefReel();
        // }
        return Response.failure(
            json.decode(response.body)["message"] ?? "Something Went Wrong",
            responseCode: response.statusCode);

      case 500:
        // if (Singleton.instance.loginUserType == 0) {
        //   Singleton.instance.setCrateLogin(false);
        //   Singleton.instance.clearPrefCrate();
        //   locationService?.stopService();
        // } else {
        //   Singleton.instance.setReelLogin(false);
        //   Singleton.instance.clearPrefReel();
        // }
        // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginViewpage);
        return Response.failure(
            json.decode(response.body)["message"] ?? "Something Went Wrong");
      default:
        return Response.failure("Something Went Wrong",
            responseCode: response.statusCode);
    }
  }

  ///upload single Image
  Future<Response<T>> multiPartRequest<T>(
    String method,
    String url, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    String? fileFieldName,
    List<File>? file,
    T Function(dynamic)? fromJson,
  }) async {
    final request = http.MultipartRequest(method, Uri.parse(url));
    log("add header : ${headers != null}");
    if (fields != null) {
      log('fields : $fields');
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }
    if (headers != null) {
      log("add header : $headers");
      headers.forEach((key, value) {
        request.headers[key] = value;
      });
    }
    if (file != null) {
      for (int i = 0; i < file.length; i++) {
        request.files.add(createMultipartFile(i.toString(), file[i]));
      }
      // request.files.add(createMultipartFile(fileFieldName!, file));
    }

    log('createMultipartFile : ${request.files.length}');
    log('createMultipartFile : ${request.files.length}');
    request.files.map((e) {
      log("e.filename : ${e.filename}");
      log("e.contentType : ${e.contentType.type}");
      log("e.field : ${e.field}");
    }).toList();
    log('request header : ${request.headers}');
    log('header : $headers');

    var response = await request.send();
    log('response : $response');
    var responseBody =
        await http.Response.fromStream(response).then((value) => value.body);

    // var responseBody = response.stream.bytesToString();
    log('response body :$responseBody');
    switch (response.statusCode) {
      case 200:
        return Response.success(fromJson!(json.decode(responseBody)));
      case 401:
        return Response.failure(
            json.decode(responseBody.toString())["message"] ??
                "Something Went Wrong");

      case 500:
        return Response.failure(
            json.decode(responseBody.toString())["message"] ??
                "Something Went Wrong");

      case 429:
        return Response.failure("Something Went Wrong");
      default:
        return Response.failure(
            json.decode(responseBody.toString())["message"] ??
                "Something Went Wrong",
            responseCode: response.statusCode);
    }
  }

  http.MultipartFile createMultipartFile(String field, File file) {
    List<int> fileBytes = file.readAsBytesSync();
    return http.MultipartFile.fromBytes(field, fileBytes, filename: file.path);
  }
}

Future<http.Response> getData(
    String baseUrl, Map<String, String> parameters) async {
  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: parameters);

  try {
    final response = await http.get(uri);
    return response;
  } catch (error) {
    throw Exception('Failed to load data: $error');
  }
}
