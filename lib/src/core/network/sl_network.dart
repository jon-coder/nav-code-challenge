import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../resources/app_resources.dart';
import '../service_locator/domain/interfaces/i_service_locator.dart';
import 'data/handlers/interceptor_handler.dart';
import 'data/handlers/request_handler.dart';
import 'data/interfaces/network_http_client.dart';
import 'data/network_impl.dart';
import 'domain/interfaces/i_network.dart';
import 'infra/dio_client.dart';

class SlNetwork implements AppResources {
  @override
  FutureOr<void> initialize() {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );

    SL.I.registerFactory<NetworkHttpClient>(
      () => DioClient(dio),
    );

    SL.I.registerFactory<InterceptorHandler>(
      () => InterceptorHandler(
        // Add all custom interceptors here.
        [],
      ),
    );

    SL.I.registerFactory<RequestHandler>(
      () => RequestHandler(
        SL.I<NetworkHttpClient>(),
        SL.I<InterceptorHandler>(),
      ),
    );

    SL.I.registerFactoryWithParams<INetwork, String, void>((baseUrl, _) {
      return NetworkImpl(
        url: baseUrl,
        requestHandler: SL.I<RequestHandler>(),
      );
    });
  }
}
