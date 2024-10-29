import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/network/data/handlers/interceptor_handler.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/interceptor_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_content_type.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response_type.dart';
import 'package:navalia_code_challenge/src/core/network/domain/interfaces/i_network_interceptor.dart';

class _MockINetworkInterceptor extends Mock implements INetworkInterceptor {}

class _MockNetworkRequest extends Mock implements NetworkRequest {}

class _MockNetworkResponse extends Mock implements NetworkResponse {}

void main() {
  late INetworkInterceptor interceptor;
  late List<INetworkInterceptor> interceptors;
  late InterceptorHandler handler;

  setUp(() {
    interceptor = _MockINetworkInterceptor();
    interceptors = [interceptor];
    handler = InterceptorHandler(interceptors);
  });

  setUpAll(() {
    registerFallbackValue(_MockNetworkRequest());
    registerFallbackValue(_MockNetworkResponse());
  });

  group('Method intercept -', () {
    test(
        'Should return [$Left] when any of the [onRequest] from interceptors in the list fails',
        () async {
      when(() => interceptor.onRequest(any())).thenAnswer((_) async => Left(
            InterceptorFailure(
              message: 'message',
              url: 'url',
              method: NetworkRequestMethod.get,
            ),
          ));

      final result = await handler.intercept<NetworkRequest>(
        input: _MockNetworkRequest(),
        interceptorCall: (interceptor, interceptedRequest) =>
            interceptor.onRequest(interceptedRequest),
        copyWithCallBack: (interceptedRequest, updatedRequest) =>
            _MockNetworkRequest(),
      );

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<InterceptorFailure>());
          expect(failure.message, equals('message'));
          expect(failure.url, equals('url'));
        },
        (request) => fail('Expected an error, but got a NetworkRequest'),
      );
    });

    test(
        'Should return [$Left] when any of the [onResponse] from interceptors in the list fails',
        () async {
      when(() => interceptor.onResponse(any())).thenAnswer((_) async => Left(
            InterceptorFailure(
              message: 'message',
              url: 'url',
              method: NetworkRequestMethod.get,
            ),
          ));

      final result = await handler.intercept<NetworkResponse>(
        input: _MockNetworkResponse(),
        interceptorCall: (interceptor, interceptedRequest) =>
            interceptor.onResponse(interceptedRequest),
        copyWithCallBack: (interceptedRequest, updatedRequest) =>
            _MockNetworkResponse(),
      );

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<InterceptorFailure>());
          expect(failure.message, equals('message'));
          expect(failure.url, equals('url'));
        },
        (request) => fail('Expected an error, but got a NetworkRequest'),
      );
    });
  });

  test(
      'Should return [$Right] when all of the [onRequest] from interceptors succeed',
      () async {
    when(() => interceptor.onRequest(any())).thenAnswer((_) async => Right(
          _MockNetworkRequest(),
        ));

    final result = await handler.intercept<NetworkRequest>(
      input: _MockNetworkRequest(),
      interceptorCall: (interceptor, interceptedRequest) =>
          interceptor.onRequest(interceptedRequest),
      copyWithCallBack: (interceptedRequest, updatedRequest) =>
          _MockNetworkRequest(),
    );

    expect(result.isRight(), true);
    result.fold(
      (failure) {
        fail('Expected an NetworkRequest, but got an error');
      },
      (request) {
        expect(request, isA<NetworkRequest>());
      },
    );
  });

  test(
      'Should return [$Right] when all of the [onResponse] from interceptors succeed',
      () async {
    when(() => interceptor.onResponse(any())).thenAnswer((_) async => Right(
          _MockNetworkResponse(),
        ));

    final result = await handler.intercept<NetworkResponse>(
      input: _MockNetworkResponse(),
      interceptorCall: (interceptor, interceptedRequest) =>
          interceptor.onResponse(interceptedRequest),
      copyWithCallBack: (interceptedRequest, updatedRequest) =>
          _MockNetworkResponse(),
    );

    expect(result.isRight(), true);
    result.fold(
      (failure) {
        fail('Expected an NetworkRequest, but got an error');
      },
      (request) {
        expect(request, isA<NetworkResponse>());
      },
    );
  });

  group('Method onRequest -', () {
    test('Should return [$Left] when [intercept] fails', () async {
      when(() => interceptor.onRequest(any())).thenAnswer(
        (_) async => Left(
          InterceptorFailure(
              message: 'message fail',
              url: 'url',
              method: NetworkRequestMethod.get),
        ),
      );
      final result = await handler.onRequest(_MockNetworkRequest());

      expect(result.isLeft(), true);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<InterceptorFailure>());
          expect(failure.message, equals('message fail'));
          expect(failure.url, equals('url'));
        },
        (request) => fail('Expected an error, but got a NetworkRequest'),
      );
    });

    test('Should return [$Right] when [intercept] succeedd', () async {
      // Arrange
      final request = _MockNetworkRequest();
      when(() => interceptor.onRequest(any()))
          .thenAnswer((_) async => Right(request));

      when(() => request.baseUrl).thenReturn('baseUrl');
      when(() => request.endpoint).thenReturn('endpoint');
      when(() => request.method).thenReturn(NetworkRequestMethod.get);
      when(() => request.body).thenReturn({});
      when(() => request.contentType).thenReturn(NetworkContentType.json);
      when(() => request.responseType).thenReturn(NetworkResponseType.json);
      when(() => request.headers).thenReturn({});
      when(() => request.queryParams).thenReturn({});
      when(() => request.timeOut).thenReturn(15000);

      when(() => request.copyWith(
            baseUrl: any(named: 'baseUrl'),
            endpoint: any(named: 'endpoint'),
            method: any(named: 'method'),
            body: any(named: 'body'),
            contentType: any(named: 'contentType'),
            responseType: any(named: 'responseType'),
            headers: any(named: 'headers'),
            queryParams: any(named: 'queryParams'),
            timeOut: any(named: 'timeOut'),
          )).thenReturn(request);

      // Act
      final result = await handler.onRequest(request);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) {
          fail('Expected a NetworkRequest, but got an error');
        },
        (returnedRequest) {
          expect(returnedRequest, isA<NetworkRequest>());
          expect(returnedRequest.baseUrl, equals('baseUrl'));
          expect(returnedRequest.endpoint, equals('endpoint'));
          expect(returnedRequest.method, equals(NetworkRequestMethod.get));
          expect(returnedRequest.body, equals({}));
          expect(returnedRequest.contentType, equals(NetworkContentType.json));
          expect(
              returnedRequest.responseType, equals(NetworkResponseType.json));
          expect(returnedRequest.headers, equals({}));
          expect(returnedRequest.queryParams, equals({}));
          expect(returnedRequest.timeOut, equals(15000));
        },
      );
    });
  });

  group('Method onResponse -', () {
    test('Should return [$Left] when [intercept] fails', () async {
      when(() => interceptor.onResponse(any())).thenAnswer(
        (_) async => Left(
          InterceptorFailure(
              message: 'message fail',
              url: 'url',
              method: NetworkRequestMethod.get),
        ),
      );
      final result = await handler.onResponse(_MockNetworkResponse());

      expect(result.isLeft(), true);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<InterceptorFailure>());
          expect(failure.message, equals('message fail'));
          expect(failure.url, equals('url'));
        },
        (request) => fail('Expected an error, but got a NetworkRequest'),
      );
    });

    test('Should return [$Right] when [intercept] succeedd', () async {
      // Arrange
      final response = _MockNetworkResponse();
      when(() => interceptor.onResponse(any()))
          .thenAnswer((_) async => Right(response));

      when(() => response.getData()).thenReturn({});
      when(() => response.url).thenReturn('url');
      when(() => response.statusCode).thenReturn(200);
      when(() => response.method).thenReturn(NetworkRequestMethod.get);
      when(() => response.headers).thenReturn({});
      when(() => response.copyWith(
          url: any(named: 'url'),
          statusCode: any(named: 'statusCode'),
          method: any(named: 'method'),
          headers: any(named: 'headers'),
          data: any(named: 'data'))).thenReturn(response);

      // Act
      final result = await handler.onResponse(response);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) {
          fail('Expected a NetworkRequest, but got an error');
        },
        (returnedRequest) {
          expect(response, isA<NetworkResponse>());
          expect(response.url, equals('url'));
          expect(response.statusCode, equals(200));
          expect(response.method, equals(NetworkRequestMethod.get));
          expect(response.headers, equals({}));
          expect(response.getData(), equals({}));
        },
      );
    });
  });
}
