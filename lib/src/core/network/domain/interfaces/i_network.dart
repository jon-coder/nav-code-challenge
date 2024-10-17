import 'package:dartz/dartz.dart';

import '../../../service_locator/domain/interfaces/i_service_locator.dart';
import '../entities/network_failure.dart';
import '../entities/network_response.dart';
import '../entities/network_response_type.dart';

abstract interface class INetwork {
  factory INetwork(String baseUrl) => SL.I(param1: baseUrl);
  String get baseUrl;

  Future<Either<NetworkFailure, NetworkResponse>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    NetworkResponseType? responseType,
  });
}
