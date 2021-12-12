import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';

import 'package:hive_game_client/src/game/api/hive_game_service.dart';
import 'package:http/http.dart' show Client;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

FutureOr<void> initExternal(
  GetIt sl, {
  required String apiBaseUrl,
  required int appVersion,
}) async {
  HttpOverrides.global = MyHttpOverrides();
  sl.registerLazySingleton(
    () => ChopperClient(
      baseUrl: apiBaseUrl,
      client: Client(),
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        CustomLogger(),
      ],
      services: [
        HiveGameService.create(),
      ],
    ),
  );
}

class CustomLogger implements RequestInterceptor, ResponseInterceptor {
  CustomLogger();

  @override
  FutureOr<Request> onRequest(Request request) async {
    log('Calling request ${request.baseUrl}${request.url}');
    log('${request.method}');
    log('${request.body}');
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    log('Response : ${response.bodyString} ${response.base.toString()}');
    return response;
  }
}
