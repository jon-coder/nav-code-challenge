import 'package:dartz/dartz.dart';

import '../entities/interceptor_failure.dart';
import '../entities/network_failure.dart';
import '../entities/network_request.dart';
import '../entities/network_response.dart';

abstract interface class INetworkInterceptor {
  Future<Either<InterceptorFailure, NetworkRequest>> onRequest(
    NetworkRequest req,
  );

  Future<Either<InterceptorFailure, NetworkResponse>> onResponse(
    NetworkResponse resp,
  );

  Future<NetworkFailure> onError(
    NetworkFailure failure,
  );
}
