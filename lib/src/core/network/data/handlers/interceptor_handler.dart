import 'package:dartz/dartz.dart';

import '../../domain/entities/interceptor_failure.dart';
import '../../domain/entities/network_failure.dart';
import '../../domain/entities/network_request.dart';
import '../../domain/entities/network_response.dart';
import '../../domain/interfaces/i_network_interceptor.dart';

class InterceptorHandler implements INetworkInterceptor {
  InterceptorHandler(this.interceptors);
  final List<INetworkInterceptor> interceptors;

  @override
  Future<NetworkFailure> onError(NetworkFailure failure) async {
    late NetworkFailure interceptedFailure;
    for (final i in interceptors) {
      final result = await i.onError(failure);
      interceptedFailure = failure.copyWith(
        message: result.message,
        statusCode: result.statusCode,
        type: result.type,
      );
    }
    return interceptedFailure;
  }

  @override
  Future<Either<InterceptorFailure, NetworkRequest>> onRequest(
    NetworkRequest req,
  ) async {
    return intercept<NetworkRequest>(
      input: req,
      interceptorCall: (
        interceptor,
        interceptedReq,
      ) =>
          interceptor.onRequest(interceptedReq),
      copyWithCallBack: (
        interceptedReq,
        updatedReq,
      ) =>
          interceptedReq.copyWith(
        baseUrl: updatedReq.baseUrl,
        endpoint: updatedReq.endpoint,
        method: updatedReq.method,
        body: updatedReq.body,
        contentType: updatedReq.contentType,
        responseType: updatedReq.responseType,
        headers: updatedReq.headers,
        queryParams: updatedReq.queryParams,
        timeOut: updatedReq.timeOut,
      ),
    );
  }

  @override
  Future<Either<InterceptorFailure, NetworkResponse>> onResponse(
    NetworkResponse resp,
  ) async {
    return intercept<NetworkResponse>(
      input: resp,
      interceptorCall: (
        interceptor,
        interceptedResp,
      ) =>
          interceptor.onResponse(interceptedResp),
      copyWithCallBack: (
        interceptedResp,
        updatedResp,
      ) =>
          interceptedResp.copyWith(
        url: updatedResp.url,
        statusCode: updatedResp.statusCode,
        headers: updatedResp.headers,
        data: updatedResp.getData(),
      ),
    );
  }

  Future<Either<InterceptorFailure, T>> intercept<T>({
    required T input,
    required InterceptorCall<T> interceptorCall,
    required CopyWithCallback<T> copyWithCallBack,
  }) async {
    T interceptedValue = input;
    for (final interceptor in interceptors) {
      final result = await interceptorCall(
        interceptor,
        interceptedValue,
      );
      result.fold((failure) {
        return failure;
      }, (result) {
        interceptedValue = copyWithCallBack(interceptedValue, result);
      });
    }
    return Right(interceptedValue);
  }
}

typedef InterceptorCall<T> = Future<Either<InterceptorFailure, T>> Function(
  INetworkInterceptor,
  T,
);

typedef CopyWithCallback<T> = T Function(
  T interceptorValue,
  T updatedValue,
);
