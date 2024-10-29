import 'package:dartz/dartz.dart';

import '../../domain/entities/interceptor_failure.dart';
import '../../domain/entities/network_content_type.dart';
import '../../domain/entities/network_failure.dart';
import '../../domain/entities/network_request.dart';
import '../../domain/entities/network_request_method.dart';
import '../../domain/entities/network_response.dart';
import '../../domain/entities/network_response_type.dart';
import '../interfaces/network_http_client.dart';
import 'interceptor_handler.dart';

class RequestHandler {
  RequestHandler(
    this.httpClient,
    this.interceptorHandler,
  );
  final NetworkHttpClient httpClient;
  final InterceptorHandler interceptorHandler;

  Future<Either<InterceptorFailure, NetworkRequest>> prepareRequest(
    NetworkRequestMethod requestMethod,
    String baseUrl,
    String endpoint, {
    body,
    NetworkContentType? contentType,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    NetworkResponseType? responseType,
  }) async {
    const timeOut = 15000;

    final request = NetworkRequest(
      baseUrl: baseUrl,
      endpoint: endpoint,
      method: requestMethod,
      body: body,
      contentType: contentType,
      responseType: responseType,
      headers: headers,
      queryParams: queryParams ?? {},
      timeOut: timeOut,
    );
    final structuredRequest = await interceptorHandler.onRequest(request);
    return structuredRequest;
  }

  Future<Either<NetworkFailure, NetworkResponse>> executeRequest(
    Either<InterceptorFailure, NetworkRequest> request,
  ) async {
    return await request.fold(
      (failure) async => Left(failure),
      (req) async {
        final result = await httpClient.request(req);
        final response = NetworkResponse.fromJson(result);
        final interceptedResponse =
            await interceptorHandler.onResponse(response);

        return interceptedResponse.fold(
          (interceptedFailure) {
            return Left(interceptedFailure);
          },
          (interceptedResponse) {
            return Right(interceptedResponse);
          },
        );
      },
    );
  }
}
