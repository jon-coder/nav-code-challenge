import 'package:dartz/dartz.dart';

import '../domain/entities/network_failure.dart';
import '../domain/entities/network_request_method.dart';
import '../domain/entities/network_response.dart';
import '../domain/entities/network_response_type.dart';
import '../domain/interfaces/i_network.dart';
import 'handlers/request_handler.dart';

class NetworkImpl implements INetwork {
  NetworkImpl({
    required this.url,
    required this.requestHandler,
  });

  final String url;
  final RequestHandler requestHandler;

  @override
  String get baseUrl => url;

  @override
  Future<Either<NetworkFailure, NetworkResponse>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.get,
      baseUrl,
      endpoint,
      headers: headers,
      queryParams: queryParams,
      responseType: responseType,
    );

    return requestHandler.executeRequest(request);
  }
}
