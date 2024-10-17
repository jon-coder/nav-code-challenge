import 'package:dio/dio.dart';

import '../data/interfaces/network_http_client.dart';
import '../domain/entities/network_request.dart';
import '../domain/entities/network_request_method.dart';
import '../domain/entities/network_response_type.dart';

class DioClient implements NetworkHttpClient {
  DioClient(this.dio);
  final Dio dio;

  @override
  Future<Map<String, dynamic>> request(NetworkRequest request) async {
    try {
      final options = Options(
        contentType: request.contentType?.name,
        headers: request.headers,
        responseType: request.responseType?.toDioType(),
        receiveTimeout: Duration(seconds: request.timeOut ?? 15),
      );

      switch (request.method) {
        case NetworkRequestMethod.get:
          return (await dio.get(
            request.url,
            queryParameters: request.queryParams,
            options: options,
          ))
              .toMap();

        case NetworkRequestMethod.post:
          return (await dio.post(
            request.url,
            queryParameters: request.queryParams,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.put:
          return (await dio.put(
            request.url,
            queryParameters: request.queryParams,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.patch:
          return (await dio.patch(
            request.url,
            queryParameters: request.queryParams,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.delete:
          return (await dio.delete(
            request.url,
            queryParameters: request.queryParams,
            options: options,
          ))
              .toMap();
      }
    } on DioException catch (e, s) {
      throw DioException(
        error: e.error,
        message: e.message,
        type: e.type,
        response: e.response,
        requestOptions: e.requestOptions,
        stackTrace: s,
      );
    }
  }
}

extension on NetworkResponseType {
  ResponseType toDioType() {
    switch (this) {
      case NetworkResponseType.json:
        return ResponseType.json;
      case NetworkResponseType.bytes:
        return ResponseType.bytes;
      case NetworkResponseType.plain:
        return ResponseType.plain;
      case NetworkResponseType.stream:
        return ResponseType.stream;
    }
  }
}

extension on Response {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': realUri.host + realUri.path,
      'method': requestOptions.method,
      'headers': requestOptions.headers,
      'statusCode': statusCode,
      'data': data
    };
  }
}
